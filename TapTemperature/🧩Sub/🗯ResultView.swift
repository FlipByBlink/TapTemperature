
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
