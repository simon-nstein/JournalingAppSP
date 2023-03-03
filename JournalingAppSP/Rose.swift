import SwiftUI
import Foundation

struct Rose: View {
    @State var address = ""
        var body: some View {
            TextField("Describe a highlight, success, small win, or something positive that happened today.", text: $address, axis: .vertical)
                .lineLimit(5...10)
                .font(.system(size: 30))
                .padding()
            
        }
}



struct Rose_Previews: PreviewProvider {
    static var previews: some View {
        Rose()

    }
}


