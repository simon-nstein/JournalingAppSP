//
//  TestTwoView.swift
//  JournalingAppSP
//
//  Created by Simon Neuwirth-Stein on 3/13/23.
//

import SwiftUI

struct TestTwoView: View {
    @State var selectedDate: Date = Date()
    @State var selectedTab: Int = 1
    var body: some View {
        
        TabView(selection: $selectedTab) {
            Text("First Tab")
                .tag(0)
            Text("Second Tab")
                .tag(1)
            Text("Third Tab")
                .tag(2)
        }
        //.tabViewStyle(PageTabViewStyle())
        //.indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .background(Color.yellow)
        //.tabViewStyle(.page)
        .overlay(
            HStack{
            
                Button(action: {
                    let previousTab = (selectedTab - 1 + 4) % 4 // calculate index of previous tab
                    selectedTab = previousTab
                }) {
                    Image(systemName: "chevron.left")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .clipShape(Circle())
                }
                .opacity(selectedTab == 0 ? 0 : 1)
                .padding(.trailing, 20)
                .padding(.bottom, 20)
                
                Button(action: {
                            let nextTab = (selectedTab + 1) % 3 // calculate index of next tab
                            selectedTab = nextTab
                        }) {
                            Image(systemName: "chevron.right")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .clipShape(Circle())
                        }
                        .opacity(selectedTab == 2 ? 0 : 1)
                        .padding(.trailing, 20)
                        .padding(.bottom, 20)
                
                
            },alignment: .bottomTrailing
            
        )
        
        
        
        
        
    }
}

struct TestTwoView_Previews: PreviewProvider {
    static var previews: some View {
        TestTwoView()
    }
}
