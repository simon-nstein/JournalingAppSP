//
//  OpenJournal.swift
//  JournalingAppSP
//
//  Created by Paul McSlarrow on 3/23/23.
//

import SwiftUI

struct OpenJournal: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(CustomColor.openJournalBackground)
                .frame(width: 350, height: 175)
            
            HStack {
                VStack (alignment: .leading) {
                    HStack {
                        TextView(text: "Open Journal", fontSize: 20, offset: 0, fontType:"Poppins-Bold").foregroundColor(CustomColor.darkTextColor)
                        Image(systemName: "arrow.right").foregroundColor(CustomColor.darkTextColor)
                    }.offset(x: -70, y: 45)
                    TextView(text: "Let your thoughts run", fontSize: 14, offset: 0, fontType: "Poppins-Regular").foregroundColor(CustomColor.subtextColor).offset(x: -70, y: 45)
                }
            }
        }
    }
}

struct OpenJournal_Previews: PreviewProvider {
    static var previews: some View {
        OpenJournal()
    }
}
