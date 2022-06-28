
import SwiftUI

struct 🕛HistoryView: View {
    @EnvironmentObject var 📱: 📱AppModel
    
    var body: some View {
        if 📱.🄷istory == "" {
            Image(systemName: "text.append")
                .foregroundStyle(.tertiary)
                .font(.system(size: 64))
                .navigationTitle("History")
                .navigationBarTitleDisplayMode(.inline)
        } else {
            ScrollView {
                Spacer()
                    .frame(height: 50)

                ScrollView(.horizontal, showsIndicators: false) {
                    Text(📱.🄷istory)
                        .font(.caption)
                        .padding()
                        .navigationTitle("History")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button {
                                    📱.🄷istory = ""
                                } label: {
                                    Image(systemName: "trash")
                                        .tint(.red)
                                }
                            }
                        }
                }
            }
        }
    }
}
