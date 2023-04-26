//
//  ContentView.swift
//  Journaling App
//
//  Created by Simon Neuwirth-Stein on 3/2/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: JournalData
    @State private var selectedTab: Tab = .house
    var userProfile: Profile
    let endingDate = Date()

    init(viewModel: JournalData) {
        self.viewModel = viewModel
        self.userProfile = Profile.empty
        UITabBar.appearance().isHidden = true
    }
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    
    
    var body: some View {
        ZStack{
    
            VStack{
                TabView(selection: $selectedTab) {
                    // Homepage
                    HomepageView(viewModel: self.viewModel, userProfile: self.userProfile, endingDate: self.endingDate)
                        .tag(Tab.house)
                    
                    // Calendar
                    CalendarView(viewModel: self.viewModel)
                        .tag(Tab.calendar)
                    
                    // Analyze
                    AnalyzeView(viewModel: self.viewModel)
                        .tag(Tab.chartBar)
                    
                    // Profile
                    profileView(userProfile: self.userProfile)
                        .tag(Tab.person)
                    
                } //end TabView
            }
            
            VStack{
                Spacer()
                CustomNavBarView(selectedTab: $selectedTab)
            }
            
        }
        
        
    }
    
    func getCurrentDate() -> String {
        let location = Locale.current
        let currentDate = Date()
        dateFormatter.dateStyle = .short
        dateFormatter.locale = location
        return dateFormatter.string(from: currentDate)
    }
    
}

struct UserImage: View {
    // Given the URL of the user’s picture, this view asynchronously
    // loads that picture and displays it. It displays a “person”
    // placeholder image while downloading the picture or if
    // the picture has failed to download.
    
    var urlString: String
    
    var body: some View {
        AsyncImage(url: URL(string: urlString)) { image in
            image
                .resizable()
                .frame(maxWidth: 64, maxHeight: 54)
                .padding()
        } placeholder: {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 64)
                .foregroundColor(.blue)
                .opacity(0.5)
        }
    }
}

struct TextView: View {
    let text: String
    let fontSize: CGFloat
    let offset: CGFloat
    let fontType: String
    
    var body: some View {
        Text(text)
            .offset(y: offset)
            .font(Font.custom(fontType, size: fontSize))
    }
}

struct ContentView_Previews: PreviewProvider {    
    static var previews: some View {
        //ContentView(viewModel: JournalData(UserProfile: Profile.empty), userProfile: Profile.empty)
        ContentView(viewModel: JournalData(UserProfile: Profile.empty))
        
    }
}
