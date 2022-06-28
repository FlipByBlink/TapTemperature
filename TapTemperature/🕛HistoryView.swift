
import SwiftUI

struct 🕛HistoryView: View {
    
    var 🅃ext: String
    
    var body: some View {
        if 🅃ext == "" {
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
//                    📋PageView(🅃ext, "History")
//                        .toolbar {
//                            ToolbarItem(placement: .navigationBarTrailing) {
//                                Button {
//                                    🅃ext = ""
//                                } label: {
//                                    Image(systemName: "trash")
//                                        .tint(.red)
//                                }
//                            }
//                        }
                    Text("placeholder")
                }
            }
        }
    }

    init(_ ⓣext: String) {
        🅃ext = ⓣext
    }
}
