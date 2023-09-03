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
        switch widgetFamily {
            case .accessoryCircular, .accessoryCorner:
                ZStack {
                    AccessoryWidgetBackground()
                    Image(systemName: "medical.thermometer")
                        .font(.largeTitle.weight(.medium))
                        .widgetAccentable()
                }
            case .accessoryInline:
                Label("Temperature", systemImage: "medical.thermometer")
                    .widgetAccentable()
            default:
                Text(verbatim: "🐛")
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
        .supportedFamilies([.accessoryCircular, .accessoryCorner, .accessoryInline])
    }
}
