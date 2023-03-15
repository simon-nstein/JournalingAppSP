//
//  HistoryView.swift
//  JournalingAppSP
//
//  Created by Simon Neuwirth-Stein on 3/11/23.
//

//This page needs to take in:
// Date
// Rose,Bud,& Thorn Response

import SwiftUI
import Foundation

struct HistoryView: View {
    //let viewModel: JournalData
    @ObservedObject var viewModel: JournalData;
    let date: String?
    
    var body: some View {
        let currentDate = date
        // date is formatted like #/#/##
        let matchingRose = viewModel.savedRoses.first{ $0.dateID == currentDate }
        let matchingBud = viewModel.savedBuds.first{ $0.dateID == currentDate }
        let matchingThorn = viewModel.savedThorns.first{ $0.dateID == currentDate }
        
        
        //changing current date style to word style
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        let date = dateFormatter.date(from: currentDate ?? "") ?? Date()

        dateFormatter.dateFormat = "MMMM d, yyyy"
        let formattedDate = dateFormatter.string(from: date)
        
        //return NavigationView{}
        return VStack{
            NavBarView()
            //Text(self.date! ?? "")
            
            Text(formattedDate)
                .foregroundColor(Color("darkColor"))
                .font(Font.custom("Poppins-Bold", size: CustomFontSize.largeFontSize))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            Spacer()
            
            List{
                Section(
                    header: Text("Rose")
                        .font(Font.custom("Poppins-SemiBold", size: CustomFontSize.inputFontSize))
                        .foregroundColor(Color("darkColor"))
                ) {
                        Text(matchingRose?.roseMessage ?? "Hi")
                            .font(Font.custom("Poppins-Regular", size: 18))
                            .foregroundColor(Color("darkColor"))
                    }
                .listRowSeparator(.hidden)
                
                Divider()
                    .background(Color("veryLightColor"))
                    .listRowSeparator(.hidden)
                
                Section(
                    header: Text("Bud")
                        .font(Font.custom("Poppins-SemiBold", size: CustomFontSize.inputFontSize))
                        .foregroundColor(Color("darkColor"))
                ) {
                        Text(matchingBud?.budMessage ?? "Hi")
                            .font(Font.custom("Poppins-Regular", size: 18))
                            .foregroundColor(Color("darkColor"))
                    }
                .listRowSeparator(.hidden)
                .offset(y: -35)
                
                Divider()
                    .background(Color("veryLightColor"))
                    .listRowSeparator(.hidden)
                    .offset(y: -35)
                
                Section(
                    header: Text("Thorn")
                        .font(Font.custom("Poppins-SemiBold", size: CustomFontSize.inputFontSize))
                        .foregroundColor(Color("darkColor"))
                ) {
                        Text(matchingThorn?.thornMessage ?? "Hi")
                            .font(Font.custom("Poppins-Regular", size: 18))
                            .foregroundColor(Color("darkColor"))
                    }
                .listRowSeparator(.hidden)
                .offset(y: -70)
            }
            .listStyle(PlainListStyle())
            
        }.navigationBarBackButtonHidden(true)

    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(
            viewModel: JournalData(), date: "3/7/23"
        )
    }
}
