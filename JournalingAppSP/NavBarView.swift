//
//  NavBarView.swift
//  JournalingAppSP
//
//  Created by Simon Neuwirth-Stein on 3/7/23.
//


import SwiftUI




struct NavBarView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack{
            Button {
                dismiss()
                } label: {
                    HStack{
                Image(systemName: "chevron.left")
                    .foregroundColor(Color("darkColor"))
                    .font(.system(size: 30))
                Spacer()
            }
                    .padding(.top)


                }


            .padding()
            //.background(Color("darkColor"))
        }
    }
}




struct NavBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavBarView()
    }
}
