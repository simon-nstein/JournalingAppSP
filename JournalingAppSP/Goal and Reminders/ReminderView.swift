//
//  ReminderView.swift
//  JournalingAppSP
//
//  Created by Paul McSlarrow on 4/24/23.
//

import SwiftUI

struct ReminderView: View {
    var viewModel: JournalData
    var userProfile: Profile
    let notifyHandler = NotificationHandler()
    @State private var selectedTime = Date()
    @State private var selection: String? = nil
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var sharedData: SharedData
    
    
    var body: some View {
        
            ZStack {
                Color("NEWbackground") // Set the background color
                    .ignoresSafeArea()
                
                VStack{
                    
                    if sharedData.userNeedsGoals {
                        Button {
                            self.notifyHandler.askPermission(date: self.selectedTime, type: "time", title: "Time to reflect", body: "Our app is here to help you keep track of your thoughts and emotions, and provide a safe space to express yourself freely.")
                            dismiss()
                        } label: {
                            HStack{
                                Image(systemName: "chevron.left")
                                    .foregroundColor(Color("responseColor"))
                                    .font(.system(size: 30))
                                Spacer()
                            }
                        }
                        .padding()
                    }
                    
                    VStack {
                        TextView(text: "Do you want to be reminded to journal everyday?", fontSize: 25, offset: 0, fontType: "Poppins-SemiBold")
                            .foregroundColor(Color("LoginHeader"))
                            .padding()
                            .multilineTextAlignment(.center)
                        TextView(text: "To see success, we highly recommend that you set up notifications that remind you to journal at a set time.", fontSize: 16, offset: 0, fontType: "Poppins-Regular")
                            .foregroundColor(Color("LoginSubtext"))
                            .padding()
                            .multilineTextAlignment(.center)
                        //Spacer()
                        
                        
                        
                        ZStack {
                            Rectangle()
                                .fill(Color("ReminderOuterBox"))
                                .frame(width: 350, height: 100)
                                .cornerRadius(10)
                            
                            Rectangle()
                                .fill(Color("ReminderBox"))
                                .frame(width: 340, height: 90)
                                .cornerRadius(10)
                            
                            HStack {
                                Image(systemName: "clock")
                                    .foregroundColor(Color("LoginHeader"))
                                    .padding(.leading, 50.0)
                                    .font(.system(size: 35))
                                Spacer()
                                
                                DatePicker("", selection: $selectedTime, displayedComponents: [ .hourAndMinute])
                                    .labelsHidden()
                                    .accentColor(Color("LoginHeader"))
                                    .padding(.trailing, 50.0)
                                
                            }.padding()
                            
                        }//.padding(.bottom, 100.0)
                        
                        
                        
                        
                        /*
                        if !sharedData.userNeedsGoals {
                            HStack {
                                
                                NavigationLink(destination: ContentView(viewModel: JournalData(UserProfile: self.userProfile))) {
                                    Text("No thanks")
                                        .font(.custom("Poppins-Regular", size: 16))
                                        .foregroundColor(Color("LoginHeader"))
                                }
                                .padding(.leading, 25.0)
                                
                                
                                
                                Spacer()
                                
                                NavigationLink(destination: ContentView(viewModel: JournalData(UserProfile: self.userProfile)).onAppear {
                                    self.notifyHandler.askPermission(date: self.selectedTime, type: "time", title: "Time to reflect", body: "Our app is here to help you keep track of your thoughts and emotions, and provide a safe space to express yourself freely.")
                                }) {
                                    Text("Schedule Reminder")
                                        .font(.custom("Poppins-Regular", size: 16))
                                    
                                }
                                .foregroundColor(Color("LoginHeader"))
                                .padding(.trailing, 25.0)
                            }//end HStack
                        }
                         */
                        
                    }
                    Spacer()
                    if !sharedData.userNeedsGoals {
                        NavigationLink(destination: ContentView(viewModel: JournalData(UserProfile: self.userProfile))) {
                            Image(systemName: "arrow.right.circle.fill")
                                .foregroundColor(Color("responseColor"))
                                .font(.system(size: 50))
                        }
                        .offset(y: -70)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding()
                        .simultaneousGesture(TapGesture().onEnded{
                            self.notifyHandler.askPermission(date: self.selectedTime, type: "time", title: "Time to reflect", body: "Our app is here to help you keep track of your thoughts and emotions, and provide a safe space to express yourself freely.")
                        })
                    }
                }//end VStack
                .offset(y: 49)
                
            }.ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
    }
}


