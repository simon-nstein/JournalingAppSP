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
    
    
    var body: some View {
        
            ZStack {
                CustomColor.darkBackground
                VStack {
                    TextView(text: "Do you want to be reminded to journal everyday?", fontSize: 25, offset: 0, fontType: "Poppins-SemiBold").foregroundColor(.white).padding(.horizontal, 25.0).multilineTextAlignment(.center)
                    TextView(text: "To see success, we highly recommend that you set up notifications that remind you to journal at a set time.", fontSize: 16, offset: 0, fontType: "Poppins-Regular").foregroundColor(.white).padding().multilineTextAlignment(.center)
                    Spacer()
                    
                    ZStack {
                        Rectangle()
                            .fill(CustomColor.reminderBackground)
                            .frame(width: 350, height: 100)
                        
                        Rectangle()
                            .fill(CustomColor.reminderInsideBackground)
                            .frame(width: 340, height: 90)
                        
                        HStack {
                            Image(systemName: "clock")
                                .foregroundColor(.white)
                                .padding(.leading, 50.0)
                            Spacer()

                            DatePicker("", selection: $selectedTime, displayedComponents: [ .hourAndMinute])
                                .labelsHidden()
                                .accentColor(.white)
                                .padding(.trailing, 50.0)

                        }.padding()
                        
                    }.padding(.bottom, 100.0)
                    
                    HStack {
                        
                        NavigationLink(destination: ContentView(viewModel: JournalData(UserProfile: self.userProfile))) {
                            Text("No thanks")
                        }.foregroundColor(.white).padding(.leading, 25.0)

                        
                        Spacer()
                        
                        NavigationLink(destination: ContentView(viewModel: JournalData(UserProfile: self.userProfile)).onAppear {
                            self.notifyHandler.askPermission(date: self.selectedTime, type: "time", title: "Time to reflect", body: "Our app is here to help you keep track of your thoughts and emotions, and provide a safe space to express yourself freely.")
                        }) {
                            Text("Schedule Reminder")
                        }.foregroundColor(.white).padding(.trailing, 25.0)
                    }
                    
                }.padding(.vertical, 100.0)
            }.ignoresSafeArea().navigationBarBackButtonHidden(true).navigationBarHidden(true)
    }
}


