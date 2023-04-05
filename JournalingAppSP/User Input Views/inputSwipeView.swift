//
//  testView.swift
//  JournalingAppSP
//
//  Created by Simon Neuwirth-Stein on 3/11/23.
//

import SwiftUI

struct inputSwipeView: View {
    @ObservedObject var viewModel: JournalData;
    @State var selectedTab: Int = 0
    
    
    var body: some View {
        NavigationView {
            VStack{
                TabView(selection: $selectedTab) {
                    InputView(viewModel: viewModel, type: "ROSE")
                        .tag(0)
                    InputView(viewModel: viewModel, type: "BUD")
                        .tag(1)
                    InputView(viewModel: viewModel, type: "THORN")
                        .tag(2)
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            } //VStack
        } //NavigationView
    }
}

struct inputSwipeView_Previews: PreviewProvider {
    static var previews: some View {
        inputSwipeView(viewModel: JournalData(), selectedTab: 0)
    }
}
