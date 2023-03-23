//
//  testView.swift
//  JournalingAppSP
//
//  Created by Simon Neuwirth-Stein on 3/11/23.
//

import SwiftUI

struct testView: View {
    @ObservedObject var viewModel: JournalData;
    @State private var selectDate = Date()
    @State private var navigate = false
    
    @State var selectedDate: Date = Date()
    let startingDate: Date = Calendar.current.date(from: DateComponents(year: 2023)) ?? Date()
    let endingDate: Date = Date()
    
    func dateToString(date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "M/d/yy" // the way the date is formatted in HistoryView
            return dateFormatter.string(from: date)
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                //Text(dateToString(date: selectDate))
                 Image(systemName: "ellipsis")
                     .font(.system(size: 30))
                     .foregroundColor(Color("veryLightColor"))
                     .overlay {
                     DatePicker(
                         "",
                         selection: $selectDate,
                         in: startingDate...endingDate,
                         displayedComponents: [.date]
                        )
                        .blendMode(.destinationOver)
                         .onChange(of: selectDate) { newValue in
                             if viewModel.savedRoses.first(where: { $0.dateID == dateToString(date: selectDate) }) != nil {
                                 navigate = true
                             }
                         }
                }
                 
                
                
                /*
                DatePicker(
                    "",
                    selection: $selectDate,
                    in: startingDate...endingDate,
                    displayedComponents: [.date]
                )
                .onChange(of: selectDate) { newValue in
                    if viewModel.savedRoses.first(where: { $0.dateID == dateToString(date: selectDate) }) != nil {
                        navigate = true
                    }
                }
                 */
                
                NavigationLink(isActive: $navigate) {
                    HistoryView(viewModel: viewModel, date: dateToString(date: selectDate))
                } label: {
                    EmptyView()
                }
            } //end VStack
            //.background(Color("darkColor"))
            
        } //end NavView
    }//end body
}//end struct

struct testView_Previews: PreviewProvider {
    static var previews: some View {
        testView(viewModel: JournalData())
    }
}
