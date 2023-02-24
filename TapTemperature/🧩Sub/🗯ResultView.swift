import SwiftUI

struct 🗯ResultView: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(📱.🚩registerSuccess ? .pink : .gray)
                .ignoresSafeArea()
            VStack {
                HStack {
                    if 📱.🚩registerSuccess { 🗑CancelButton() }
                    Spacer()
                    if 📱.🚩registerSuccess == false {
                        Image(systemName: "arrow.right")
                            .imageScale(.small)
                            .font(.largeTitle)
                    }
                    💟JumpButton()
                }
                .opacity(0.75)
                .padding(.horizontal, 20)
                Button {
                    📱.ⓡeset()
                } label: {
                    VStack(spacing: 12) {
                        Spacer()
                        Image(systemName: 📱.🚩registerSuccess ? "checkmark" : "exclamationmark.triangle")
                            .font(.system(size: 100).weight(.semibold))
                            .minimumScaleFactor(0.1)
                        Text(📱.🚩registerSuccess ? "DONE!" : "Error!?")
                            .font(.system(size: 128).weight(.black))
                            .lineLimit(1)
                            .minimumScaleFactor(0.1)
                            .padding(.horizontal)
                        if 📱.🚩registerSuccess {
                            Text("Registration for \"Health\" app")
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
                        HStack {
                            if 📱.🚩basalTempOption && 📱.🛏basalSwitch {
                                Image(systemName: "bed.double")
                                    .font(.body.bold())
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
                }
                .accessibilityLabel("Dismiss")
                .opacity(📱.🚩canceled ? 0.25 : 1)
            }
        }
        .preferredColorScheme(.dark)
        .animation(.default, value: 📱.🚩canceled)
        .modifier(📣ADContent())
        .onDisappear {
            📱.🚩registerSuccess = false
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
                .font(.title)
                .imageScale(.large)
                .foregroundColor(.primary)
                .padding(.vertical)
        }
        .disabled(📱.🚩canceled)
        .opacity(📱.🚩canceled ? 0.5 : 1)
        .accessibilityLabel("Cancel")
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
}
