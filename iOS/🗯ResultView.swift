import SwiftUI

struct 🗯ResultView: View {
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
                        .strikethrough(self.model.canceled)
                        .font(.system(size: 128).weight(.black))
                        .lineLimit(1)
                        .minimumScaleFactor(0.1)
                        .padding(.horizontal)
                    if self.model.registrationSuccess {
                        Text(#"Registration for "Health" app"#)
                            .strikethrough(self.model.canceled)
                            .bold()
                            .opacity(0.8)
                    } else {
                        Text(#"Please check permission on "Health" app"#)
                            .font(.body.weight(.semibold))
                            .foregroundColor(.secondary)
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
                .opacity(self.model.canceled ? 0.25 : 1)
                .modifier(Self.CanceledLabel())
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
                    }
                    💟OpenHealthApp.buttonOnToolbar()
                        .foregroundStyle(.white)
                }
                ToolbarItemGroup(placement: .bottomBar) {
                    if self.model.registrationSuccess { self.cancelButton() }
                }
            }
            .animation(.default, value: self.model.canceled)
            .onDisappear { self.model.registrationSuccess = false }
            //.modifier(💬RequestUserReview())
        }
    }
}

private extension 🗯ResultView {
    private func dismissButton() -> some View {
        Button {
            self.model.reset()
        } label: {
            Label("Dismiss", systemImage: "xmark.circle")
        }
        .tint(.white)
    }
    private func cancelButton() -> some View {
        Button {
            self.model.cancel()
        } label: {
            Image(systemName: "arrow.uturn.backward.circle")
                .font(.title3)
        }
        .tint(.white)
        .disabled(self.model.canceled)
        .opacity(self.model.canceled ? 0.5 : 1)
        .accessibilityLabel("Cancel")
    }
    private struct CanceledLabel: ViewModifier {
        @EnvironmentObject var model: 📱AppModel
        func body(content: Content) -> some View {
            content
                .overlay(alignment: .bottom) {
                    if self.model.canceled {
                        VStack {
                            Text("Canceled")
                                .fontWeight(.semibold)
                            if self.model.cancelError {
                                Text("(perhaps error)")
                            }
                        }
                        .foregroundStyle(.white)
                    }
                }
                .animation(.default, value: self.model.canceled)
        }
    }
}

//private struct 💬RequestUserReview: ViewModifier {
//    @State private var ⓒheckToRequest: Bool = false
//    func body(content: Content) -> some View {
//        content
//            .modifier(💬PrepareToRequestUserReview(self.$ⓒheckToRequest))
//            .onAppear {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                    self.ⓒheckToRequest = true
//                }
//            }
//    }
//}
