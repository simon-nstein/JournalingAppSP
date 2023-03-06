import SwiftUI
import Foundation

struct Rose: View {
    @ObservedObject var viewModel: JournalData;
    @State var userInput = ""
        var body: some View {
            VStack() {
                HStack{
                    Text("Highlight a success, small win, or something positive that happened today or that you are planning for today.")
                        .padding(.leading)
                        .foregroundColor(CustomColor.TextColor)
                    
                    Spacer()
                }
                TextField(
                    "Start Typing...",
                    text: $userInput,
                    axis: .vertical
                )
                    .lineLimit(5...100)
                    .padding()
            
                    // Saving the data
                    .onChange(of: userInput) {
                        self.viewModel.roseInput = $0
                        self.viewModel.addRose(with: $0)
                        self.viewModel.saveData()
                    }
                    .onAppear {
                        self.userInput = self.viewModel.getTodaysRose() ?? ""
                    }
                
                
                Spacer()
                Image(systemName: "mic.circle.fill")
                    .offset(y: -20)
                    .font(.system(size: 60))
                    .foregroundColor(.black)
            }
            .offset(y: 40)
            .background(CustomColor.RoseColor)
            .font(Font.custom("Poppins-Medium", size: CustomFontSize.RoseFontSize))
            
        }
        
}
struct Rose_Previews: PreviewProvider {
    static var previews: some View {
        Rose(viewModel: JournalData())
    }
}


