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
            .navigationTitle("Your week at a glance").font(Font.custom("Poppins-Medium", size: 20))
            .navigationBarBackButtonHidden(true)
        }
    }
    
}

struct WeekGlance_Previews: PreviewProvider {
    static var previews: some View {
        WeekGlance(viewModel: JournalData())
    }
}
