//
//  testView.swift
//  JournalingAppSP
//
//  Created by Simon Neuwirth-Stein on 3/11/23.
//

import SwiftUI

struct gratSwipeView: View {
    @ObservedObject var viewModel: JournalData;
    @State var selectedTab: Int = 0
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        NavigationView {
            VStack{
                Button {
                    dismiss()
                } label: {
                    HStack{
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color("NextArrowBackgroundColor"))
                            .font(.system(size: 30))
                        Spacer()
                    }
                }//END BACK BUTTON
                .padding(.top)
                .padding(.leading)
                
                TabView(selection: $selectedTab) {
                    InputView(viewModel: viewModel, type: "GRAT1")
                        .tag(0)
                    InputView(viewModel: viewModel, type: "GRAT2")
                        .tag(1)
                    InputView(viewModel: viewModel, type: "GRAT3")
                        .tag(2)
                }
                .overlay(
                    HStack(alignment: .lastTextBaseline){
                        
                        if selectedTab == 0 { pageNumber(page: "1 of 3 responses") }
                        if selectedTab == 1 { pageNumber(page: "2 of 3 responses") }
                        if selectedTab == 2 { pageNumber(page: "3 of 3 responses") }
                        
                        Button(action: {
                            let previousTab = (selectedTab - 1 + 4) % 4 // calculate index of previous tab
                            selectedTab = previousTab
                        }) {
                            Image(systemName: "chevron.left.circle.fill")
                                .font(.system(size: 55))
                                .foregroundColor(Color("NextArrowBackgroundColor"))
                        }
                        .opacity(selectedTab == 0 ? 0 : 1)
                        //.padding(.leading, 50)
                        .padding(.bottom, 80)
                        
                        Button(action: {
                                    if selectedTab == 0 || selectedTab == 1{
                                        let nextTab = (selectedTab + 1) % 3 // calculate index of next tab
                                        selectedTab = nextTab
                                    }else{
                                        if self.viewModel.gratitude1Input != "" && self.viewModel.gratitude2Input != "" && self.viewModel.gratitude3Input != "" {
                                            dismiss()
                                        }
                                    }
                            
                                }) {
                                    if selectedTab == 0 || selectedTab == 1{
                                            Image(systemName: "chevron.right.circle.fill")
                                                .font(.system(size: 55))
                                                .foregroundColor(Color("NextArrowBackgroundColor"))
                                    } else if selectedTab == 2 {
                                        Image(systemName: "checkmark.circle.fill")
                                            .font(.system(size: 55))
                                            //.foregroundColor(Color("NextArrowBackgroundColor"))
                                            .foregroundColor(self.viewModel.gratitude1Input == "" || self.viewModel.gratitude2Input == "" || self.viewModel.gratitude3Input == "" ? Color("NOTNextArrowBackgroundColor") : Color("NextArrowBackgroundColor"))
                                    }
                                }
                                .padding(.trailing, 20)
                                .padding(.bottom, 80)
                        
                        
                    },alignment: .bottomTrailing
                    
                )
            } //VStack
            .background(Color("NEWbackground"))
        } //NavigationView
        .navigationBarBackButtonHidden(true)
        .background(Color("NEWbackground"))
    }
}

struct gratSwipeView_Previews: PreviewProvider {
    static var previews: some View {
        gratSwipeView(viewModel: JournalData(UserProfile: Profile.empty), selectedTab: 0)
    }
}
