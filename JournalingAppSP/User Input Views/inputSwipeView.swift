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
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        NavigationView {
            VStack{
                //NavBarView()
                Button {
                    dismiss()
                } label: {
                    HStack{
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color("darkColor"))
                            .font(.system(size: 30))
                        Spacer()
                    }
                }
                    .padding(.top)
                TabView(selection: $selectedTab) {
                    InputView(viewModel: viewModel, type: "ROSE")
                        .tag(0)
                    InputView(viewModel: viewModel, type: "BUD")
                        .tag(1)
                    InputView(viewModel: viewModel, type: "THORN")
                        .tag(2)
                }
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
            } //VStack
        } //NavigationView
        .navigationBarBackButtonHidden(true)
    }
}

struct inputSwipeView_Previews: PreviewProvider {
    static var previews: some View {
        inputSwipeView(viewModel: JournalData(UserProfile: Profile.empty), selectedTab: 0)
    }
}
