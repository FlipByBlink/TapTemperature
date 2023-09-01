import SwiftUI

enum 💟OpenHealthApp {
    static var url: URL { .init(string: "x-apple-health://")! }
    static var title: LocalizedStringKey { #"Open "Health" app"# }
    static func buttonOnToolbar() -> some View {
        Link(destination: Self.url) {
            Image(systemName: "app")
                .font(.title3)
                .overlay {
                    Image(systemName: "heart")
                        .resizable()
                        .font(.title3.weight(.semibold))
                        .scaleEffect(0.5)
                }
        }
        .foregroundStyle(.primary)
        .accessibilityLabel(Self.title)
    }
    static func buttonOnList() -> some View {
        Link (destination: Self.url) {
            HStack {
                Label {
                    Text(Self.title)
                } icon: {
                    Image(systemName: "app")
                        .imageScale(.large)
                        .overlay {
                            Image(systemName: "heart")
                                .resizable()
                                .font(.body.weight(.semibold))
                                .scaleEffect(0.5)
                        }
                }
                Spacer()
                Image(systemName: "arrow.up.forward.app")
                    .foregroundStyle(.secondary)
            }
        }
    }
}
