//
//  TestTwoView.swift
//  JournalingAppSP
//
//  Created by Simon Neuwirth-Stein on 3/13/23.
//

import SwiftUI

struct TestTwoView: View {
    @State var selectedDate: Date = Date()
    var body: some View {
        Image(systemName: "ellipsis")
            .font(.system(size: 50))
            .overlay {
                DatePicker("", selection: $selectedDate, displayedComponents: [.date])
                    .blendMode(.destinationOver)
            }
        
    }
}

struct TestTwoView_Previews: PreviewProvider {
    static var previews: some View {
        TestTwoView()
    }
}
