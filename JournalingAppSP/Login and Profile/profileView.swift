//
//  profileView.swift
//  JournalingAppSP
//
//  Created by Paul McSlarrow on 3/15/23.
//

import SwiftUI

struct profileView: View {
    let userProfile: Profile
    
    var body: some View {
        
        VStack {
            
            // User picture, name, and email
            
            /*
            UserImage(urlString: userProfile.picture)
                .padding()
             */
            
            Spacer()
        
            VStack {
                TextView(
                    text: userProfile.email,
                    fontSize: 22,
                    offset: 0,
                    fontType: "Poppins-SemiBold"
                )
                TextView(
                    text: "Joined in 2020",
                    fontSize: 14,
                    offset: 0,
                    fontType: "Poppins-Light"
                )
            }
            Divider()
            Spacer()
            
            
            // User Data
            ScrollView {
                
                BarView(
                    image: "flame",
                    text: "Current Streak",
                    statistic: "3 days"
                )
                Divider()
                
                BarView(
                    image: "flame",
                    text: "Longest Streak",
                    statistic: "9 days"
                )
                Divider()
                
                BarView(
                    image: "flame",
                    text: "This Week",
                    statistic: "2/7 Days"
                )
                Divider()
                
                BarView(
                    image: "flame",
                    text: "This Month",
                    statistic: "10/30 Days"
                )
                Divider()
                
                BarView(
                    image: "flame",
                    text: "This Year",
                    statistic: "50/365 days"
                )
                Divider()

            }
        }
    }
}

struct BarView: View {
    let image: String
    let text: String
    let statistic: String
    
    //let darkBlue = CustomColor.darkBlue
    //let textColor = CustomColor.TextColor
    
    let darkBlue = Color.red
    let textColor = Color.blue
    
    var body: some View {
        HStack {
            Image(systemName: image)
                .foregroundColor(darkBlue)
                .padding(.horizontal)
        
            Text(text)
                .font(Font.custom("Poppins-SemiBold", size: 20))
                .foregroundColor(textColor)
            
            
            Spacer()
            
            Text(statistic)
                .font(Font.custom("Poppins-Regular", size: CustomFontSize.standardFontSize))
                .padding(.horizontal)
        }
    }
}


struct profileView_Previews: PreviewProvider {
    
    static var previews: some View {
        profileView(userProfile: Profile(
            id: "id",
            name: "Paul McSlarrow",
            email: "pmcslarrow@icloud.com",
            emailVerified: "True",
            picture: "",
            updatedAt: "",
            id_string: ""
        ))
    }
}
