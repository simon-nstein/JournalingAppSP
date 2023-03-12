//
//  WeekGlance.swift
//  JournalingAppSP
//
//  Created by Paul McSlarrow on 3/5/23.
//

import SwiftUI

struct GlanceView: View {
    let viewModel: JournalData
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                
                HStack(){
                    Text("Week")
                    Spacer()
                    Text("Month")
                    Spacer()
                    Text("6 Months")
                    Spacer()
                    Text("Year")
                }
                .padding()
                
                
                /*
                ForEach(viewModel.savedRoses, id: \.self) { rose in
                    HStack {
                        Text(rose.roseMessage ?? "")
                        Spacer()
                        Text(rose.dateID!)
                    }
                }
                
                
                
                
                
                List {
                    Section(
                        header: Text("Rose")) {
                            ForEach(viewModel.savedRoses, id: \.self) { rose in
                                HStack {
                                    Text(rose.roseMessage ?? "")
                                    Spacer()
                                    Text(rose.dateID!)
                                }
                            }
                        }
                    
                    Section(
                        header: Text("Bud")) {
                            ForEach(viewModel.savedBuds, id: \.self) { bud in
                                HStack {
                                    Text(bud.budMessage ?? "")
                                    Spacer()
                                    Text(bud.dateID!)
                                }
                            }
                        }
                    
                    Section(
                        header: Text("Thorn")) {
                            ForEach(viewModel.savedThorns, id: \.self) { thorn in
                                HStack {
                                    Text(thorn.thornMessage ?? "")
                                    Spacer()
                                    Text(thorn.dateID!)
                                }
                            }
                        }
                }
                 */
            }
                 
        }//end of list
    }
    
}

struct GlanceView_Previews: PreviewProvider {
    static var previews: some View {
        GlanceView(viewModel: JournalData())
    }
}
