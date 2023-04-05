//
//  ContentView.swift
//  Journaling App
//
//  Created by Simon Neuwirth-Stein on 3/2/23.
//

import SwiftUI
//poppins font

struct ContentView: View {
    @ObservedObject var viewModel: JournalData;
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var userProfile: Profile
    @State var selectedDate = Date()
    
    
    let startingDate: Date = Calendar.current.date(from: DateComponents(year: 2023)) ?? Date()
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
            aboutUs()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Calendar")
                }
            
            // Analyze
            aboutUs()
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
    }
    
    func getCurrentDate() -> String {
        let location = Locale.current
        let currentDate = Date()
        dateFormatter.dateStyle = .short
        dateFormatter.locale = location
        return dateFormatter.string(from: currentDate)
    }
    
    
    // A View that allows you to easily reuse code to turn values into a "card"
    struct Cardify: View {
        let viewModel: JournalData
        let title: String
        let paragraph: String
        let image: Image
        //let imageName: String
        
        var cardColor: Color {
            switch(title) {
                case "Rose":
                    return CustomColor.RoseColor
                case "Thorn":
                    return CustomColor.BudColor
                case "Bud":
                    return CustomColor.ThornColor
                default:
                    return CustomColor.TextColor
            }
        }
        

        
        var body: some View {
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 350, height: 100)
                .foregroundColor(self.cardColor)
                .overlay(
                    HStack{
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100.0)
                        
                        VStack(alignment: .leading) {
                            HStack{
                                Text(self.title)
                                    .font(Font.custom("Poppins-SemiBold", size: CustomFontSize.inputFontSize))
                                    .foregroundColor(Color("darkColor"))
                            }
                            Text(self.paragraph)
                                .font(Font.custom("Poppins-Regular", size: CustomFontSize.standardFontSize))
                                .foregroundColor(CustomColor.TextColor)
                                .multilineTextAlignment(.leading)
                    
                        }
                        .padding([.top, .bottom, .trailing], 6.0)
                        .offset(x: -10)
                        .foregroundColor(.black)
                        
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color("veryLightColor"))
                            .padding([.top, .bottom, .trailing])
                            .font(.system(size: 24))
                        
                    }
                )
                .padding(.vertical, 8.0)
        }
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
        ContentView(viewModel: JournalData(), userProfile: Profile.empty)
    }
}
