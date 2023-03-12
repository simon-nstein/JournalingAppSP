//
//  testView.swift
//  JournalingAppSP
//
//  Created by Simon Neuwirth-Stein on 3/11/23.
//

import SwiftUI

struct testView: View {
    @ObservedObject var viewModel: JournalData;
    
    
    var body: some View {
        /*
         TabView {
         Text("First View")
         Text("Second View")
         Text("Third View")
         }
         //.tabViewStyle(PageTabViewStyle())
         .background(Color.blue)
         //.tabViewStyle(.page)
         .tabViewStyle(PageTabViewStyle())
         .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
         */
         
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
         
        
        Text("Hi")
        
    }
}

struct testView_Previews: PreviewProvider {
    static var previews: some View {
        testView(viewModel: JournalData())
    }
}
