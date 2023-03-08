//
//  SwiftUIView.swift
//  JournalingAppSP
//
//  Created by Simon Neuwirth-Stein on 3/7/23.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        Image("roseIMG")
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
