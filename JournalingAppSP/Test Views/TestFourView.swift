//
//  TestFourView.swift
//  JournalingAppSP
//
//  Created by Simon Neuwirth-Stein on 4/17/23.
//

import SwiftUI

struct TestFourView: View {
    var body: some View {
        HStack(alignment: .firstTextBaseline){
            Image(systemName: "heart.fill")
                .font(.system(size: 18))
            .background(Color.red)
            
            
            
            VStack(alignment: .leading){
                Text("test").font(.system(size: 26))
                Text("Rose").font(.system(size: 22))
            }
            .background(Color.blue)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.yellow)
    }
}

struct TestFourView_Previews: PreviewProvider {
    static var previews: some View {
        TestFourView()
    }
}
