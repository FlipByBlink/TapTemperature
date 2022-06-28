
import SwiftUI

struct 🕛HistoryView: View {
    @EnvironmentObject var 📱: 📱AppModel
    
    var body: some View {
        if 📱.🕒History == "" {
            Image(systemName: "text.append")
                .foregroundStyle(.tertiary)
                .font(.system(size: 64))
                .navigationTitle("History")
                .navigationBarTitleDisplayMode(.inline)
        } else {
            ScrollView {
                ScrollView(.horizontal, showsIndicators: false) {
                    Text(📱.🕒History)
                        .font(.subheadline)
                        .padding()
                        .textSelection(.enabled)
                        .navigationTitle("History")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button {
                                    📱.🕒History = ""
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
