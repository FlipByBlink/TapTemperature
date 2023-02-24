import SwiftUI

struct 🗯ResultView: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack { ⓒontent() }
        } else {
            NavigationView { ⓒontent() }
        }
    }
    private func ⓒontent() -> some View {
        ZStack {
            Rectangle()
                .foregroundColor(📱.🚩registerSuccess ? .pink : .gray)
                .ignoresSafeArea()
            VStack(spacing: 12) {
                Spacer()
                Image(systemName: 📱.🚩registerSuccess ? "checkmark" : "exclamationmark.triangle")
                    .font(.system(size: 100).weight(.semibold))
                    .minimumScaleFactor(0.1)
                Text(📱.🚩registerSuccess ? "DONE!" : "Error!?")
                    .strikethrough(📱.🚩canceled)
                    .font(.system(size: 128).weight(.black))
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
                    .padding(.horizontal)
                if 📱.🚩registerSuccess {
                    Text("Registration for \"Health\" app")
                        .strikethrough(📱.🚩canceled)
                        .bold()
                        .opacity(0.8)
                } else {
                    Text("Please check permission on \"Health\" app")
                        .font(.body.weight(.semibold))
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.1)
                        .padding(.horizontal)
                }
                Spacer()
                VStack(spacing: 10) {
                    if 📱.🚩basalTempOption {
                        Text(📱.🛏bbtInputMode ? "Basal body temperature" : "Body temperature")
                            .lineLimit(1)
                            .font(.caption.bold())
                            .minimumScaleFactor(0.1)
                    }
                    if 📱.🚩registerSuccess {
                        Text(📱.🌡value.description + " " + 📱.📏unitOption.rawValue)
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                }
                .padding(.bottom, 24)
                .opacity(0.8)
                Spacer()
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .opacity(📱.🚩canceled ? 0.25 : 1)
            .modifier(🗑CanceledLabel())
        }
        .preferredColorScheme(.dark)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                self.ⓓismissButton()
            }
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                if 📱.🚩registerSuccess == false {
                    Image(systemName: "arrow.right")
                        .imageScale(.small)
                        .font(.largeTitle)
                }
                💟JumpButton()
            }
            ToolbarItemGroup(placement: .bottomBar) {
                if 📱.🚩registerSuccess { 🗑CancelButton() }
            }
        }
        .animation(.default, value: 📱.🚩canceled)
        .modifier(📣ADContent())
        .onDisappear {
            📱.🚩registerSuccess = false
        }
    }
    private func ⓓismissButton() -> some View {
        Button {
            📱.ⓡeset()
        } label: {
            Label("Dismiss", systemImage: "xmark.circle")
                .foregroundColor(.primary)
                .imageScale(.large)
        }
    }
}

struct 🗑CancelButton: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        Button {
            📱.🗑cancel()
        } label: {
            Image(systemName: "arrow.uturn.backward.circle")
                .imageScale(.large)
                .foregroundColor(.primary)
        }
        .disabled(📱.🚩canceled)
        .opacity(📱.🚩canceled ? 0.5 : 1)
        .accessibilityLabel("Cancel")
    }
}

struct 🗑CanceledLabel: ViewModifier {
    @EnvironmentObject var 📱: 📱AppModel
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .bottom) {
                if 📱.🚩canceled {
                    VStack {
                        Text("Canceled")
                            .fontWeight(.semibold)
                        if 📱.🚨cancelError {
                            Text("(perhaps error)")
                        }
                    }
                }
            }
            .animation(.default, value: 📱.🚩canceled)
    }
}
