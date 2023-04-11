//
//  WeekGlance.swift
//  JournalingAppSP
//
//  Created by Paul McSlarrow on 3/5/23.
//

import SwiftUI

struct WeekGlance: View {
    let viewModel: JournalData
    
    var body: some View {
        NavigationView {
            List {
                Section(
                    header: Text("Roses")
                        .font(Font.custom("Poppins-Medium", size: CustomFontSize.inputFontSize))
                        .foregroundColor(Color("darkColor"))
                    
                ) {
                        ForEach(viewModel.savedRoses, id: \.self) { rose in
                            NavigationLink(destination: HistoryView(viewModel: viewModel, date: rose.dateID)){
                                HStack {
                                    Text(rose.roseMessage ?? "")
                                    Spacer()
                                    Text(rose.dateID!)
                                }
                                .font(Font.custom("Poppins-Regular", size: CustomFontSize.standardFontSize))
                                .foregroundColor(Color("darkColor"))
                                
                            }
                            
                        }.listRowSeparator(.hidden)
                    }
                
                Divider()
                    .background(Color("veryLightColor"))
                    .listRowSeparator(.hidden)
                
                Section(
                    header: Text("Buds")
                        .font(Font.custom("Poppins-Medium", size: CustomFontSize.inputFontSize))
                        .foregroundColor(Color("darkColor"))
                ) {
                        ForEach(viewModel.savedBuds, id: \.self) { bud in
                            NavigationLink(destination: HistoryView(viewModel: viewModel, date: bud.dateID)){
                                HStack {
                                    Text(bud.budMessage ?? "")
                                    Spacer()
                                    Text(bud.dateID!)
                                }
                                .font(Font.custom("Poppins-Regular", size: CustomFontSize.standardFontSize))
                                .foregroundColor(Color("darkColor"))
                            }
                        }.listRowSeparator(.hidden)
                        
                    }.offset(y:-30)
                
                Divider()
                    .background(Color("veryLightColor"))
                    .listRowSeparator(.hidden)
                    .offset(y:-30)
                
                Section(
                    header: Text("Thorns")
                        .font(Font.custom("Poppins-Medium", size: CustomFontSize.inputFontSize))
                        .foregroundColor(Color("darkColor"))
                ) {
                        ForEach(viewModel.savedThorns, id: \.self) { thorn in
                            NavigationLink(destination: HistoryView(viewModel: viewModel, date: thorn.dateID)){
                                HStack {
                                    Text(thorn.thornMessage ?? "")
                                    Spacer()
                                    Text(thorn.dateID!)
                                }
                                .font(Font.custom("Poppins-Regular", size: CustomFontSize.standardFontSize))
                                .foregroundColor(Color("darkColor"))
                            }
                        }.listRowSeparator(.hidden)
                    }.offset(y:-60)
            }//end of list
            .listStyle(PlainListStyle())
            //.navigationTitle("Your week at a glance")
            //.font(Font.custom("Poppins-Medium", size: 20))
            
        }//end nav view
    }
    
}



struct WeekGlance_Previews: PreviewProvider {
    static var previews: some View {
        WeekGlance(viewModel: JournalData(UserProfile: Profile.empty))
    }
}
