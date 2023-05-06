//
//  profileView.swift
//  JournalingAppSP
//
//  Created by Paul McSlarrow on 3/15/23.
//

import SwiftUI
import Auth0

struct profileView: View {
    @ObservedObject var viewModel: JournalData;
    let userProfile: Profile

    
    var body: some View {
        NavigationView {
                ZStack{
                    
                    Color("NEWbackground") // Set the background color
                        .ignoresSafeArea()
                    
                    VStack {
                        
                        Circle()
                            .fill(Color(red: 0.67, green: 0.80, blue: 0.9))
                            .frame(width: 100, height: 100)
                        
                        Text("\(userProfile.name)")
                            .font(Font.custom("Poppins-SemiBold", size: 20))
                            .foregroundColor(Color("mainTextColor"))
                            .padding(.bottom, 30)
                        
                        // User Data
                        ScrollView {
                            
                            VStack{
                                BarView(
                                    image: "flame.fill",
                                    text: "Current Streak",
                                    imageColor: "HeartRed",
                                    count: "\(viewModel.getStreak()) days"
                                    
                                )
                                
                                Divider()
                                
                                BarView(
                                    image: "calendar",
                                    text: "This Week",
                                    imageColor: "mainTextColor",
                                    count: "\(viewModel.getPeriodStreak(period: "week"))/7 days"
                                )
                                Divider()
                                
                                BarView(
                                    image: "calendar",
                                    text: "This Month",
                                    imageColor: "mainTextColor",
                                    count: "\(viewModel.getPeriodStreak(period: "month"))/31 days"
                                )
                                Divider()
                                
                                BarView(
                                    image: "calendar",
                                    text: "This Year",
                                    imageColor: "mainTextColor",
                                    count: "\(viewModel.getPeriodStreak(period: "year"))/365 days"
                                )
                                Divider()
                            }
                            
                            NavigationLink(destination: SettingsView(viewModel: self.viewModel, userProfile: self.userProfile)) {
                                Text("Settings")
                                    .foregroundColor(Color("LogoutText"))
                                    .font(.custom("Poppins-SemiBold", size: 20))
                                    .padding()
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .background(Color("LogoutBox"))
                                    .cornerRadius(10)
                            }.padding()
                                
                            
                            
                                NavigationLink(destination: LoginSystemView()) {
                                    Text("Logout")
                                        .foregroundColor(Color("LogoutText"))
                                        .font(.custom("Poppins-SemiBold", size: 20))
                                        .padding()
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .background(Color("LogoutBox"))
                                        .cornerRadius(10)
                                }
                                .padding(.horizontal)
                                .simultaneousGesture(TapGesture().onEnded{
                                    //loginSystemView.logout()
                                    print("logout")
                                })
                            }
            
                            
                        }
                    }//end VStack
                    .offset(y: 20)
                }//end ZStack
            
        }
        
}

struct BarView: View {
    let image: String
    let text: String
    //let statistic: String
    let imageColor: String
    let count: String
    
    let darkBlue = Color.red
    let textColor = Color.blue
    
    
    var body: some View {
        HStack {
            Image(systemName: image)
                .foregroundColor(Color(imageColor))
                .padding(.horizontal)
        
            Text(text)
                .font(Font.custom("Poppins-Medium", size: 20))
                .foregroundColor(Color("mainTextColor"))
            
            Spacer()
            
            Text(count)
                .font(Font.custom("Poppins-Medium", size: CustomFontSize.standardFontSize))
                .foregroundColor(Color("mainTextColor"))
                .padding(.horizontal)
        }
    }
}


