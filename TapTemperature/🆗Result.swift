
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
                    if 📱.🚩BasalTemp && 📱.🛏Is {
                        Image(systemName: "bed.double")
                            .font(.largeTitle)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                    
                    if 📱.🚩Success == false {
                        Image(systemName: "arrow.right")
                            .imageScale(.small)
                            .font(.largeTitle)
                            .foregroundStyle(.secondary)
                    }
                    
                    💟JumpButton()
                        .opacity(0.66)
                }
                .overlay {
                    if 📱.🚩Success && 📱.🚩AutoComplete {
                        Text(📱.💾Temp.description + " " + 📱.💾Unit.rawValue)
                            .font(.title.weight(.medium))
                            .monospacedDigit()
                            .opacity(0.66)
                    }
                }
                .padding(.top)
                .padding(.horizontal, 20)
                
                Button {
                    📱.🚩InputDone = false
                } label: {
                    VStack(spacing: 12) {
                        Image(systemName: 📱.🚩Success ? "app.badge.checkmark" : "exclamationmark.triangle")
                            .font(.system(size: 110).weight(.semibold))
                            .minimumScaleFactor(0.1)
                        
                        Text(📱.🚩Success ? "OK!" : "🌏Error!?")
                            .font(.system(size: 128).weight(.black))
                            .lineLimit(1)
                            .minimumScaleFactor(0.1)
                        
                        if 📱.🚩Success == false {
                            Text("🌏Please check permission on \"Health\" app")
                                .font(.body.weight(.semibold))
                                .foregroundColor(.secondary)
                                .lineLimit(1)
                                .minimumScaleFactor(0.1)
                                .padding(.horizontal)
                        }
                        
                        Spacer()
                            .frame(height: 50)
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .accessibilityLabel("🌏Dismiss")
            }
        }
        .preferredColorScheme(.dark)
    }
}




struct 🆗Result_Previews: PreviewProvider {
    static var previews: some View {
        🆗Result()
            .previewLayout(.fixed(width: 200, height: 400))
    }
}
