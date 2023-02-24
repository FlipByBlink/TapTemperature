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
                📣ADBanner()
            }
        }
        .preferredColorScheme(.dark)
        .animation(.default, value: 📱.🚩canceled)
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

struct 📣ADBanner: View {
    @EnvironmentObject var 📱: 📱AppModel
    @EnvironmentObject var 🛒: 🛒StoreModel
    @State private var 🚩showBanner = false
    @AppStorage("🄻aunchCount") private var ⓛaunchCount: Int = 0
    var body: some View {
        Group {
            if 🛒.🚩Purchased || !📱.🚩registerSuccess {
                Spacer()
            } else {
                if self.🚩showBanner {
                    📣ADView(without: .TapTemperature)
                        .padding(.horizontal)
                        .background {
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .foregroundStyle(.background)
                                .shadow(radius: 3)
                        }
                        .padding()
                        .frame(maxHeight: 180)
                        .environment(\.colorScheme, .light)
                } else {
                    Spacer()
                }
            }
        }
        .onAppear {
            self.ⓛaunchCount += 1
            if self.ⓛaunchCount > 5 { self.🚩showBanner = true }
        }
    }
}
//ADMenuSheetを表示したままアプリをバックグラウンドに移行した際に、ResultViewの自動非表示機能がうまく動作しない。
//そのためADBanner上のADMenuシートを削除。
