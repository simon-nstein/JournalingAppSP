//
//  GratitudeJournal.swift
//  JournalingAppSP
//
//  Created by Paul McSlarrow on 3/23/23.
//

import SwiftUI

struct GratitudeJournal: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(CustomColor.gratitudeBackground)
                .frame(width: 350, height: 175)
            
            HStack {
                VStack (alignment: .leading) {
                    HStack {
                        TextView(text: "Gratitude Journal", fontSize: 20, offset: 0, fontType:"Poppins-Bold").foregroundColor(CustomColor.darkTextColor)
                        Image(systemName: "arrow.right").foregroundColor(CustomColor.darkTextColor)
                    }.offset(x: -20, y: 45)
                    TextView(text: "Reflect about what you’re grateful for", fontSize: 14, offset: 0, fontType: "Poppins-Regular").foregroundColor(CustomColor.subtextColor).offset(x: -20, y: 45)
                }
            }
        }
    }
}

struct GratitudeJournal_Previews: PreviewProvider {
    static var previews: some View {
        GratitudeJournal()
    }
}
