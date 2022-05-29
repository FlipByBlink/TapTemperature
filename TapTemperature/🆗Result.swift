
import SwiftUI


struct 🆗Result: View {
    @EnvironmentObject var 📱:📱Model
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(📱.🚩Success ? .pink : .gray)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    if 📱.🚩Success {
                        Button {
                            📱.🗑Cancel()
                        } label: {
                            Image(systemName: "arrow.uturn.backward.circle")
                                .font(.title)
                                .imageScale(.large)
                                .foregroundColor(.primary)
                                .padding(.vertical)
                        }
                        
                        if 📱.🚩Canceled {
                            Text("Canceled")
                                .fontWeight(.semibold)
                        }
                    }
                    
                    Spacer()
                    
                    if 📱.🚩Success == false {
                        Image(systemName: "arrow.right")
                            .imageScale(.small)
                            .font(.largeTitle)
                    }
                    
                    💟JumpButton()
                }
                .opacity(0.75)
                .padding(.horizontal, 20)
                
                Button {
                    📱.🚩InputDone = false
                    
                    📱.🚩Canceled = false
                    
                    📱.🧩Reset()
                } label: {
                    VStack(spacing: 12) {
                        Spacer()
                        
                        Image(systemName: 📱.🚩Success ? "checkmark" : "exclamationmark.triangle")
                            .font(.system(size: 110).weight(.semibold))
                            .minimumScaleFactor(0.1)
                        
                        Text(📱.🚩Success ? "DONE!" : "🌏Error!?")
                            .font(.system(size: 128).weight(.black))
                            .lineLimit(1)
                            .minimumScaleFactor(0.1)
                            .padding(.horizontal)
                        
                        if 📱.🚩Success {
                            Text("Registration for \"Health\" app")
                                .bold()
                                .opacity(0.8)
                        } else {
                            Text("🌏Please check permission on \"Health\" app")
                                .font(.body.weight(.semibold))
                                .foregroundColor(.secondary)
                                .lineLimit(1)
                                .minimumScaleFactor(0.1)
                                .padding(.horizontal)
                        }
                        
                        Spacer()
                        
                        HStack {
                            if 📱.🚩BasalTemp && 📱.🛏BasalSwitch {
                                Image(systemName: "bed.double")
                                    .font(.body.bold())
                            }
                            
                            if 📱.🚩Success {
                                Text(📱.🌡Temp.description + " " + 📱.💾Unit.rawValue)
                                    .font(.title2)
                                    .fontWeight(.bold)
                            }
                        }
                        .padding(48)
                        .opacity(0.8)
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .accessibilityLabel("🌏Dismiss")
                .opacity(📱.🚩Canceled ? 0.25 : 1)
            }
        }
        .preferredColorScheme(.dark)
        .animation(.default, value: 📱.🚩Canceled)
    }
}
