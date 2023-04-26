//
//  TestSixView.swift
//  JournalingAppSP
//
//  Created by Simon Neuwirth-Stein on 4/23/23.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case house
    case calendar
    case leaf
    case person
}

struct CustomNavBarView: View {
    
    @Binding var selectedTab: Tab
    private var imageName: String {
            selectedTab.rawValue
        }
    
    
    var body: some View {
        
        VStack{
            HStack{
                ForEach(Tab.allCases, id: \.rawValue){ tab in
                    Spacer()
                    Image(systemName: selectedTab == tab ? imageName: tab.rawValue)
                        .foregroundColor(selectedTab == tab ? .red : .gray)
                        .font(.system(size: 22))
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.1)) {
                                selectedTab = tab
                            }
                        }
                    Spacer()
                }
                
            }
            .frame(width: nil, height: 60)
            .background(.thinMaterial)
            .cornerRadius(10)
            .padding()
        }
        
    }
}

struct CustomNavBarView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBarView(selectedTab: .constant(.house))
    }
}
