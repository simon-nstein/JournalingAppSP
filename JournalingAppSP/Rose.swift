import SwiftUI
import Foundation

struct Rose: View {
    @ObservedObject var viewModel: JournalData;
    @AppStorage("ROSE_KEY") var roseText = ""
    @State var userInput = ""
        var body: some View {
            VStack() {
                
                TextField(
                    "Describe a highlight, success, small win, or something positive that happened today.",
                    text: $userInput,
                    axis: .vertical
                )
                    .lineLimit(5...100)
                    .font(.system(size: CustomFontSize.largeFontSize))
                    .padding()
                    .lineSpacing(10)
            
                    // Saving the data
                    .onChange(of: userInput) {
                        self.viewModel.roseInput = $0
                        self.roseText = $0
                    }
                    .onAppear {
                        self.userInput = self.roseText
                    }
                
                
                Spacer()
                Image(systemName: "mic.circle.fill")
                    .offset(y: -20)
                    .font(.system(size: 60))
                    .foregroundColor(.black)
            }
            .offset(y: 40)
            .background(CustomColor.RoseColor)
        }
}
struct Rose_Previews: PreviewProvider {
    static var previews: some View {
        Rose(viewModel: JournalData())
    }
}


