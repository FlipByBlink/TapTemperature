import SwiftUI

struct 💟OpenHealthAppButton: View {
    var body: some View {
        Link(destination: URL(string: "x-apple-health://")!) {
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
        .accessibilityLabel("Open \"Health\" app")
    }
}
