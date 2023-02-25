import SwiftUI

struct 💟JumpButton: View {
    var body: some View {
        Link(destination: URL(string: "x-apple-health://")!) {
            Image(systemName: "app")
                .imageScale(.large)
                .overlay {
                    Image(systemName: "heart")
                        .resizable()
                        .font(.body.weight(.semibold))
                        .scaleEffect(0.5)
                }
        }
        .foregroundStyle(.primary)
        .accessibilityLabel("Open \"Health\" app")
    }
}
