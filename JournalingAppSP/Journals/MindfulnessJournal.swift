//
//  MindfulnessJournal.swift
//  JournalingAppSP
//
//  Created by Paul McSlarrow on 3/22/23.
//

import SwiftUI

struct MindfulnessJournal: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(CustomColor.mindfulnessBackground)
                .frame(width: 350, height: 175)
            
            HStack {
                VStack (alignment: .leading) {
                    HStack {
                        TextView(text: "Mindfulness Journal", fontSize: 20, offset: 0, fontType: "Poppins-Bold").foregroundColor(CustomColor.darkTextColor)
                        Image(systemName: "arrow.right")
                    }.padding([.top, .trailing], 80.0)
                    TextView(text: "Share your daily highs, lows, and future", fontSize: 14, offset: 0, fontType: "Poppins-Regular").foregroundColor(CustomColor.subtextColor)
                }
            }
        }
    }
}

struct MindfulnessJournal_Previews: PreviewProvider {
    static var previews: some View {
        MindfulnessJournal()
    }
}
