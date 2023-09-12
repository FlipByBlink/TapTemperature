import SwiftUI

struct 🗯ResultScreen: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .foregroundColor(self.model.registrationSuccess ? .pink : .gray)
                    .ignoresSafeArea()
                VStack(spacing: 12) {
                    Spacer()
                    Image(systemName: self.model.registrationSuccess ? "checkmark" : "exclamationmark.triangle")
                        .font(.system(size: 100).weight(.semibold))
                        .minimumScaleFactor(0.1)
                    Text(self.model.registrationSuccess ? "DONE!" : "Error!?")
                        .strikethrough(self.model.undid)
                        .font(.system(size: 128).weight(.black))
                        .lineLimit(1)
                        .minimumScaleFactor(0.1)
                        .padding(.horizontal)
                    if self.model.registrationSuccess {
                        Text(#"Registration for "Health" app"#)
                            .strikethrough(self.model.undid)
                            .bold()
                            .opacity(0.8)
                    } else {
                        Text(#"Please check permission on "Health" app"#)
                            .font(.body.weight(.semibold))
                            .foregroundStyle(.white.opacity(0.8))
                            .lineLimit(1)
                            .minimumScaleFactor(0.1)
                            .padding(.horizontal)
                    }
                    Spacer()
                    VStack(spacing: 10) {
                        if self.model.ableBBT {
                            Text(self.model.activeMode.label)
                                .lineLimit(1)
                                .font(.caption.weight(.semibold))
                                .minimumScaleFactor(0.1)
                        }
                        if self.model.registrationSuccess {
                            Text(self.model.registeredValueLabel)
                                .strikethrough(self.model.undid)
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
                .opacity(self.model.undid ? 0.25 : 1)
                .modifier(Self.UndidLabel())
            }
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    self.dismissButton()
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    if self.model.registrationSuccess == false {
                        Image(systemName: "arrow.right")
                            .imageScale(.small)
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                    }
                    💟OpenHealthApp.buttonOnToolbar()
                        .foregroundStyle(.white)
                }
                ToolbarItemGroup(placement: .bottomBar) {
                    if self.model.registrationSuccess { Self.UndoButton() }
                }
            }
            .animation(.default, value: self.model.undid)
            .onDisappear { self.model.clearRegistrationState() }
            .modifier(Self.RequestUserReview())
        }
    }
}

private extension 🗯ResultScreen {
    private func dismissButton() -> some View {
        Button {
            self.model.reset()
        } label: {
            Label("Dismiss", systemImage: "xmark.circle")
        }
        .tint(.white)
    }
    private struct UndoButton: View {
        @EnvironmentObject var model: 📱AppModel
        var body: some View {
            Button {
                self.model.undo()
            } label: {
                Image(systemName: "arrow.uturn.backward.circle")
                    .font(.title3)
            }
            .foregroundStyle(.white)
            .disabled(self.model.undid || self.model.processingUndo)
            .opacity(self.model.undid ? 0.5 : 1)
            .accessibilityLabel("Undo")
            .overlay(alignment: .top) {
                if self.model.processingUndo {
                    ProgressView()
                        .offset(y: -16)
                }
            }
        }
    }
    private struct UndidLabel: ViewModifier {
        @EnvironmentObject var model: 📱AppModel
        func body(content: Content) -> some View {
            content
                .overlay(alignment: .bottom) {
                    if self.model.undid {
                        VStack {
                            Text("Undid")
                                .fontWeight(.semibold)
                            if self.model.failedUndo {
                                Text("(perhaps error)")
                            }
                        }
                        .foregroundStyle(.white)
                    }
                }
                .animation(.default, value: self.model.undid)
        }
    }
    private struct RequestUserReview: ViewModifier {
        @Environment(\.requestReview) var requestReview
        @AppStorage("launchCount") private var launchCount: Int = 0
        func body(content: Content) -> some View {
            content
                .task {
                    self.launchCount += 1
                    try? await Task.sleep(for: .seconds(1))
                    if [20, 40, 60].contains(self.launchCount) {
                        self.requestReview()
                    }
                }
        }
    }
}
