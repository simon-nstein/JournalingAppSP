import SwiftUI
import Foundation

struct Rose: View {
    @State var address = ""
        var body: some View {
            VStack() {
                TextField("Describe a highlight, success, small win, or something positive that happened today.", text: $address, axis: .vertical)
                    .lineLimit(5...100)
                    .font(.system(size: 30))
                    .padding()
                    .lineSpacing(10)
                Spacer()
                Image(systemName: "mic.circle.fill")
                    .offset(y: -20)
                    .font(.system(size: 60))
                    .foregroundColor(.black)
            }
            .offset(y: 40)
            .background(Color(red: 0.9803921568627451, green: 0.9254901960784314, blue: 0.8941176470588236))
        }
}
struct Rose_Previews: PreviewProvider {
    static var previews: some View {
        Rose()

    }
}


