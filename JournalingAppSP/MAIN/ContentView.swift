//
//  ContentView.swift
//  Journaling App
//
//  Created by Simon Neuwirth-Stein on 3/2/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: JournalData;
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var userProfile: Profile
    //@State var selectedDate = Date()
    
    
    //let startingDate: Date = Calendar.current.date(from: DateComponents(year: 2023)) ?? Date()
    let endingDate = Date()
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    //Added for DatePicker
    @State private var selectDate = Date()
    @State private var navigate = false
    //End take out
    
    var body: some View {
        
        TabView {
            // Homepage
            HomepageView(viewModel: self.viewModel, userProfile: self.userProfile, endingDate: self.endingDate)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            // Calendar
            CalendarView(viewModel: self.viewModel)
                .tabItem {
                    //Label("Calendar", systemImage: "calendar")
                    Image(systemName: "calendar")
                    Text("Calendar")
                }
            
            // Analyze
            AnalyzeView(viewModel: self.viewModel)
                .tabItem {
                    Image(systemName: "chart.bar")
                    Text("Analyze")
                }
            
            // Profile
            profileView(userProfile: self.userProfile)
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
            
        }
        //EDIT
        //.accentColor(.red)
        //.background(Color.white) // add a white background to the TabView
        //.edgesIgnoringSafeArea(.all)
        
         
        
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
        ContentView(viewModel: JournalData(UserProfile: Profile.empty), userProfile: Profile.empty)
    }
}
