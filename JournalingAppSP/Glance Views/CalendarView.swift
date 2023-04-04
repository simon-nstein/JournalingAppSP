//
//  CalendarView.swift
//  JournalingAppSP
//
//  Created by Paul McSlarrow on 4/3/23.
//

import SwiftUI

struct CalendarView: View {
    @State var chosenDate: Date = Date()
    
    var body: some View {
        VStack() {
            dateSelector
            TextView(text: "Mindfulness Responses", fontSize: 20, offset: 0, fontType: "Poppins-Bold")
            TextView(text: "Gratitude Responses", fontSize: 20, offset: 0, fontType: "Poppins-Bold")
            TextView(text: "Open Journal", fontSize: 20, offset: 0, fontType: "Poppins-Bold")
            
        }
    }
    
    var dateSelector: some View {
        DatePicker(
            "",
            selection: $chosenDate,
            in: Date()...,
            displayedComponents: [.date]
        ).frame(width: 0).padding(.vertical)
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
