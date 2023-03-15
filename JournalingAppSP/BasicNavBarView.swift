//
//  NavBarView.swift
//  JournalingAppSP
//
//  Created by Simon Neuwirth-Stein on 3/7/23.
//

import SwiftUI


struct BasicNavBarView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack{
            HStack{
                Text("Done")
                    .opacity(0)
                Spacer()
                Text("Mar 6, 2023")
                    .foregroundColor(CustomColor.TextColor).ignoresSafeArea(edges: .top)
                    .font(.system(size: 20))
                    .bold()
                Spacer()
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Text("Done")
                            .foregroundColor(CustomColor.TextColor)
                            .font(.system(size: 20))
                    }
                }
            }
            .padding()
            //.background(CustomColor.RoseColor) //the color should depend on what they click on
            .background(Color.blue)
        }
    }
}


struct BasicNavBarView_Previews: PreviewProvider {
    static var previews: some View {
        BasicNavBarView()
    }
}
