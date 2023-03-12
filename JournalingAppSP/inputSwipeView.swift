//
//  testView.swift
//  JournalingAppSP
//
//  Created by Simon Neuwirth-Stein on 3/11/23.
//

import SwiftUI

struct inputSwipeView: View {
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
    }
}

struct inputSwipeView_Previews: PreviewProvider {
    static var previews: some View {
        inputSwipeView(viewModel: JournalData(), selectedTab: 0)
    }
}
