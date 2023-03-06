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
                            Text(rose.roseMessage ?? "")
                        }
                        .onDelete(perform: deleteRose)
                        .onMove(perform: { indices, newOffset in
                            self.viewModel.savedRoses.move(fromOffsets: indices, toOffset: newOffset)
                        })
                    }
                
            }
            .navigationTitle("Your week at a glance").font(Font.custom("Poppins-Medium", size: 20))
            .navigationBarItems(leading: EditButton())
        }
    }
    
    func deleteRose(from indexSet: IndexSet) {
        self.viewModel.savedRoses.remove(atOffsets: indexSet)
    }
}

struct WeekGlance_Previews: PreviewProvider {
    static var previews: some View {
        WeekGlance(viewModel: JournalData())
    }
}
