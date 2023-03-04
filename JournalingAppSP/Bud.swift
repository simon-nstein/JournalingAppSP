import SwiftUI
import Foundation

struct Bud: View {
    @ObservedObject var viewModel: JournalData;
    @AppStorage("BUD_KEY") var budText = ""
    @State var userInput = ""
        var body: some View {
            VStack() {
                
                TextField(
                    "A challenge you experienced or something you can use more support with.",
                    text: $userInput,
                    axis: .vertical
                )
                    .lineLimit(5...100)
                    .font(.system(size: CustomFontSize.largeFontSize))
                    .padding()
                    .lineSpacing(10)
            
                    // Saving the data
                    .onChange(of: userInput) {
                        self.viewModel.budInput = $0
                        self.budText = $0
                    }
                    .onAppear {
                        self.userInput = self.budText
                    }
                
                
                Spacer()
                Image(systemName: "mic.circle.fill")
                    .offset(y: -20)
                    .font(.system(size: 60))
                    .foregroundColor(.black)
            }
            .offset(y: 40)
            .background(CustomColor.BudColor)
        }
}
