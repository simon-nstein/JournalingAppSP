//
//  testView.swift
//  JournalingAppSP
//
//  Created by Simon Neuwirth-Stein on 3/11/23.
//

import SwiftUI

struct testView: View {
    @ObservedObject var viewModel: JournalData;
    //var type: String
    @State var selectedTab: Int
    
    
    var body: some View {
        VStack{
            NavBarView()
            TabView(selection: $selectedTab) {
                InputView(viewModel: viewModel, type: "BUD")
                    .tag(0)
                InputView(viewModel: viewModel, type: "ROSE")
                    .tag(1)
                InputView(viewModel: viewModel, type: "THORN")
                    .tag(2)
                }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
        
         
         
        /*
         List {
             Section(
                 header: Text("Thorn")) {
                     Text("Item 1")
                     Text("Item 2")
                     Text("Item 3")
                }
                     .listRowSeparator(.hidden)
        }
        .listStyle(PlainListStyle())
         */
         
        
    }
}

struct testView_Previews: PreviewProvider {
    static var previews: some View {
        testView(viewModel: JournalData(), selectedTab: 0)
    }
}
