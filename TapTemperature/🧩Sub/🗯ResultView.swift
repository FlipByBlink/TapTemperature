
import SwiftUI

struct 🗯ResultView: View {
    @EnvironmentObject var 📱: 📱AppModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(📱.🚩RegisterSuccess ? .pink : .gray)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    if 📱.🚩RegisterSuccess {
                        🗑CancelButton()
                    }
                    
                    Spacer()
                    
                    if 📱.🚩RegisterSuccess == false {
                        Image(systemName: "arrow.right")
                            .imageScale(.small)
                            .font(.largeTitle)
                    }
                    
                    💟JumpButton()
                }
                .opacity(0.75)
                .padding(.horizontal, 20)
                
                
                Button {
                    📱.🅁eset()
                } label: {
                    VStack(spacing: 12) {
                        Spacer()
                        
                        Image(systemName: 📱.🚩RegisterSuccess ? "checkmark" : "exclamationmark.triangle")
                            .font(.system(size: 100).weight(.semibold))
                            .minimumScaleFactor(0.1)
                        
                        Text(📱.🚩RegisterSuccess ? "DONE!" : "Error!?")
                            .font(.system(size: 128).weight(.black))
                            .lineLimit(1)
                            .minimumScaleFactor(0.1)
                            .padding(.horizontal)
                        
                        if 📱.🚩RegisterSuccess {
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
                            if 📱.🚩BasalTempOption && 📱.🛏BasalSwitch {
                                Image(systemName: "bed.double")
                                    .font(.body.bold())
                            }
                            
                            if 📱.🚩RegisterSuccess {
                                Text(📱.🌡Temp.description + " " + 📱.📏UnitOption.rawValue)
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
                .opacity(📱.🚩Canceled ? 0.25 : 1)
                
                
                📣ADBanner()
            }
        }
        .preferredColorScheme(.dark)
        .animation(.default, value: 📱.🚩Canceled)
        .onDisappear {
            📱.🚩RegisterSuccess = false
        }
    }
}


struct 🗑CancelButton: View {
    @EnvironmentObject var 📱: 📱AppModel
    
    var body: some View {
        Button {
            📱.🗑Cancel()
        } label: {
            Image(systemName: "arrow.uturn.backward.circle")
                .font(.title)
                .imageScale(.large)
                .foregroundColor(.primary)
                .padding(.vertical)
        }
        .disabled(📱.🚩Canceled)
        .opacity(📱.🚩Canceled ? 0.5 : 1)
        .accessibilityLabel("Cancel")
        
        if 📱.🚩Canceled {
            VStack {
                Text("Canceled")
                    .fontWeight(.semibold)
                
                if 📱.🚨CancelError {
                    Text("(perhaps error)")
                }
            }
        }
    }
}



struct 📣ADBanner: View {
    @EnvironmentObject var 📱: 📱AppModel
    @EnvironmentObject var 🛒: 🛒StoreModel
    @State private var 🚩ShowBanner = false
    @AppStorage("🄻aunchCount") var 🄻aunchCount: Int = 0
    
    var body: some View {
        Group {
            if 🛒.🚩Purchased || !📱.🚩RegisterSuccess {
                Spacer()
            } else {
                if 🚩ShowBanner {
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
            🄻aunchCount += 1
            if 🄻aunchCount > 5 { 🚩ShowBanner = true }
        }
    }
}
//ADMenuSheetを表示したままアプリをバックグラウンドに移行した際に、ResultViewの自動非表示機能がうまく動作しない。
//そのためADBanner上のADMenuシートを削除。
