import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: .now)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        completion(SimpleEntry(date: .now))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        completion(Timeline(entries: [SimpleEntry(date: .now)], policy: .never))
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct TTWidgetEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    var body: some View {
        switch widgetFamily {
            case .accessoryCircular, .accessoryCorner:
                ZStack {
                    AccessoryWidgetBackground()
                    Image(systemName: "medical.thermometer")
                        .font(.largeTitle.weight(.medium))
                }
                .widgetAccentable()
            case .accessoryInline:
                Label("Temperature", systemImage: "medical.thermometer")
                    .widgetAccentable()
            default:
                Text("🐛")
        }
    }
}

@main
struct TTWidget: Widget {
    let kind: String = "TTWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { _ in
            TTWidgetEntryView()
        }
        .configurationDisplayName("Shortcut")
        .supportedFamilies([.accessoryCircular,
                            .accessoryCorner,
                            .accessoryInline])
    }
}

struct TTWidget_Previews: PreviewProvider {
    static var previews: some View {
        TTWidgetEntryView()
            .previewContext(WidgetPreviewContext(family: .accessoryCorner))
    }
}
