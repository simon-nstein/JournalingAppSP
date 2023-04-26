//
//  TestSixView.swift
//  JournalingAppSP
//
//  Created by Simon Neuwirth-Stein on 4/23/23.
//

import SwiftUI

struct TestSixView: View {
    var body: some View {
        ZStack{
            Color.green
            .edgesIgnoringSafeArea(.all)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.green) // Add this line
        }
    }
}

struct TestSixView_Previews: PreviewProvider {
    static var previews: some View {
        TestSixView()
    }
}
