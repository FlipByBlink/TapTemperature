
import SwiftUI

struct 🛠MenuSheet: View {
    @Environment(\.dismiss) var 🔙: DismissAction
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack { 🄲ontent() }
        } else {
            NavigationView { 🄲ontent() }
        }
    }
    func 🄲ontent() -> some View {
        List {
            🛠AppMenu()
            ℹ️AboutAppLink()
            📣ADMenuLink()
        }
        .navigationTitle("Body Temperature")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    🔙.callAsFunction()
                } label: {
                    Image(systemName: "chevron.down")
                        .foregroundStyle(.secondary)
                        .grayscale(1.0)
                        .padding(8)
                }
                .accessibilityLabel("Dismiss")
            }
        }
    }
}

struct ℹ️AboutAppLink: View {
    var body: some View {
        Section {
            GeometryReader { 📐 in
                VStack(spacing: 12) {
                    Image("TapTemperature")
                        .resizable()
                        .mask { RoundedRectangle(cornerRadius: 22.5, style: .continuous) }
                        .shadow(radius: 3, y: 1)
                        .frame(width: 100, height: 100)
                    VStack(spacing: 6) {
                        Text("TapTemperature")
                            .font(.system(.title2, design: .rounded))
                            .fontWeight(.bold)
                            .tracking(1.5)
                            .opacity(0.75)
                            .lineLimit(1)
                            .minimumScaleFactor(0.1)
                        Text("Application for iPhone")
                            .font(.footnote)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                    }
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
                }
                .padding(20)
                .padding(.top, 8)
                .frame(width: 📐.size.width)
            }
            .frame(height: 200)
            
            Link(destination: URL(string: "https://apps.apple.com/app/id1626760566")!) {
                HStack {
                    Label("Open AppStore page", systemImage: "link")
                    Spacer()
                    Image(systemName: "arrow.up.forward.app")
                        .imageScale(.small)
                        .foregroundStyle(.secondary)
                }
            }
            
            NavigationLink  {
                ℹ️AboutAppMenu()
            } label: {
                Label("About App", systemImage: "doc")
            }
        }
    }
}
