import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry { .init() }
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        completion(.init())
    }
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        completion(Timeline(entries: [.init()], policy: .never))
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date = .now
}

struct 🪧WidgetEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    var body: some View {
        Group {
            switch widgetFamily {
                case .accessoryCircular:
                    ZStack {
                        AccessoryWidgetBackground()
                        Image(systemName: "medical.thermometer")
                            .font(.largeTitle.weight(.medium))
                            .widgetAccentable()
                    }
                case .accessoryInline:
                    Label("Temperature", systemImage: "medical.thermometer")
                        .widgetAccentable()
#if os(watchOS)
                case .accessoryCorner:
                    ZStack {
                        AccessoryWidgetBackground()
                        Image(systemName: "medical.thermometer")
                            .font(.title.weight(.medium))
                            .widgetAccentable()
                    }
#endif
                default:
                    Text(verbatim: "🐛")
            }
        }
        .modifier(Self.ContainerBackground())
    }
    private struct ContainerBackground: ViewModifier {
        func body(content: Content) -> some View {
            if #available(iOS 17.0, watchOS 10.0, *) {
                content.containerBackground(.background, for: .widget)
            } else {
                content
            }
        }
    }
}

@main
struct 🪧Widget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "TTWidget", provider: Provider()) { _ in
            🪧WidgetEntryView()
        }
        .configurationDisplayName("Shortcut")
        .description("Shortcut to add a data.")
#if os(iOS)
        .supportedFamilies([.accessoryCircular, .accessoryInline])
#elseif os(watchOS)
        .supportedFamilies([.accessoryCircular, .accessoryCorner, .accessoryInline])
#endif
    }
}
