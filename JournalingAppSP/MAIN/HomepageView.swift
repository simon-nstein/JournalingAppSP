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

func HPshowDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM d"
        return dateFormatter.string(from: date)
}

struct HomepageView: View {
    var viewModel: JournalData
    var userProfile: Profile
    var endingDate: Date
    
    var body: some View {
        NavigationView{
            VStack {
                homepageHeader
                
                NavigationLink(destination: aboutUs()){
                    navigationBar
                }
                
                ScrollView {
                    NavigationLink(destination: inputSwipeView(viewModel: self.viewModel)) {
                        MindfulnessJournal()
                    }
                    
                    NavigationLink(destination: gratSwipeView(viewModel: self.viewModel)) {
                        GratitudeJournal()
                    }
                    
                    NavigationLink(destination: openView(viewModel: self.viewModel)) {
                        OpenJournal()
                    }
                    
                    NavigationLink(destination: TestFiveView(viewModel: self.viewModel)) {
                        OpenJournal()
                    }
                    
                } //ScrollView
            } //VStack
            .background(Color("NEWbackground"))
        }
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
                Text("Today")
                    .font(.custom("Poppins-Bold", size: 30))
                    .foregroundColor(Color("mainTextColor"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                
                Text(HPshowDate(date: self.endingDate))
                    .font(.custom("Poppins-Regular", size: 25))
                    .foregroundColor(Color("mainTextColor"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
            } //VStack
            
            Spacer()
            
            NavigationLink(destination: FavoriteView(viewModel: self.viewModel)) {
                Image(systemName: "heart")
                    .foregroundColor(Color("responseColor"))
                    .font(.system(size: 30))
                    .padding(.trailing)
            }
            
        } //HStack
        .background(Color("NEWbackground"))
    }
}

struct HomepageView_Previews: PreviewProvider {
    static var previews: some View {
        HomepageView(viewModel: JournalData(UserProfile: Profile.empty), userProfile: Profile.empty, endingDate: Date())
    }
}
