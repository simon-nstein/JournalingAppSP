//
//  HomepageView.swift
//  JournalingAppSP
//
//  Created by Paul McSlarrow on 3/24/23.
//

import SwiftUI

func dateToString(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "M/d/yy" // the way the date is formatted in HistoryView
    return dateFormatter.string(from: date)
}

struct HomepageView: View {
    var viewModel: JournalData
    var userProfile: Profile
    var endingDate: Date
    
    var body: some View {
        NavigationView {
            VStack {
                homepageHeader
                
                NavigationLink(destination: aboutUs()){
                    navigationBar
                }
                
                ScrollView {
                    NavigationLink(destination: inputSwipeView(viewModel: self.viewModel)) {
                        MindfulnessJournal()
                    }
                    
                    NavigationLink(destination: aboutUs()) {
                        GratitudeJournal()
                    }
                    
                    NavigationLink(destination: InputView(viewModel: self.viewModel, type: "OPEN")) {
                        OpenJournal()
                    }
                    
                    NavigationLink(destination: TestThreeView(viewModel: self.viewModel)) {
                        OpenJournal()
                    }
                } //ScrollView
            } //VStack
        } // Navigation
        .padding()
    }
    
    var navigationBar: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 375, height: 30)
                .foregroundColor(CustomColor.TextColor)
            
            HStack {
                TextView(
                    text: "Learn about the benefits of journaling",
                    fontSize: 13,
                    offset: 0,
                    fontType: "Poppins-Regular"
                ).foregroundColor(.white).frame(width: 300)
                Image(systemName: "arrow.right")
                    .font(.system(size: 20, weight: .light))
                    .foregroundColor(.white)
            }
        }
        
    }
    
    var homepageHeader: some View {
        HStack {
            //Today and the date
            VStack {
                TextView(
                    text: "Today",
                    fontSize: 30,
                    offset: 0,
                    fontType: "Poppins-Bold"
                )
                
                TextView(
                    text: dateToString(date: self.endingDate),
                    fontSize: 25,
                    offset: 0,
                    fontType: "Poppins-Regular"
                )
            } //VStack
            
            Spacer()
            
            // Favorites Page
            Image(systemName: "heart")
                .resizable()
                .frame(width: 40, height: 35)
                .padding()
                .onTapGesture {
                    // Navigate to the favorites page
                }
        } //HStack
    }
}

struct HomepageView_Previews: PreviewProvider {
    static var previews: some View {
        HomepageView(viewModel: JournalData(UserProfile: Profile.empty), userProfile: Profile.empty, endingDate: Date())
    }
}
