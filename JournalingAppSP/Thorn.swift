import SwiftUI
import Foundation

struct Thorn: View {
    @ObservedObject var viewModel: JournalData;
    @AppStorage("THORN_KEY") var thornText = ""
    @State var userInput = ""
        var body: some View {
            VStack() {
                
                TextField(
                    "New ideas that have blossomed or something you are looking forward to knowing more about or experiencing.",
                    text: $userInput,
                    axis: .vertical
                )
                    .lineLimit(5...100)
                    .font(.system(size: CustomFontSize.largeFontSize))
                    .padding()
                    .lineSpacing(10)
            
                    // Saving the data
                    .onChange(of: userInput) {
                        self.viewModel.thornInput = $0
                        self.thornText = $0
                    }
                    .onAppear {
                        self.userInput = self.thornText
                    }
                
                
                Spacer()
                Image(systemName: "mic.circle.fill")
                    .offset(y: -20)
                    .font(.system(size: 60))
                    .foregroundColor(.black)
            }
            .offset(y: 40)
            .background(CustomColor.ThornColor)
        }
}
