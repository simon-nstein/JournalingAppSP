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
    let settingsPageNavigation: Bool? // If the user gets to the ReminderView from the settings page, we need to change the way it acts a little. Which is the point of this
    @State private var isToggled = false
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
                            
                        }
                   
                    }
                    Spacer()
                    if !sharedData.userNeedsGoals {
                        if self.settingsPageNavigation! {
                            HStack {
                                Toggle("Notifications", isOn: $isToggled)
                                    .padding()
                                    .foregroundColor(Color("LogoutText"))
                                    .font(.custom("Poppins-SemiBold", size: 14))
                                    .toggleStyle(SwitchToggleStyle(tint: Color("LogoutText")))
                                    .onChange(of: isToggled) { newValue in
                                        print("Toggling notification")
                                        if (newValue) {
                                            self.notifyHandler.enableNotifications()
                                            self.viewModel.enableNotification()
                                        } else {
                                            self.notifyHandler.disableNotifications()
                                            self.viewModel.disableNotification()
                                        }
                                    }
                                
                                
                                Button("Submit") {
                                    self.notifyHandler.askPermission(date: self.selectedTime, type: "time", title: "Time to reflect", body: "Our app is here to help you keep track of your thoughts and emotions, and provide a safe space to express yourself freely.")
                                    dismiss()
                                }
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .buttonStyle(myButtonStyle())
                                .padding()
                            }.offset(y: -150)
                            
                        } else {
                            NavigationLink(destination: ContentView(viewModel: JournalData(UserProfile: self.userProfile))) {
                                Image(systemName: "arrow.right.circle.fill")
                                    .foregroundColor(Color("responseColor"))
                                    .font(.system(size: 50))
                            }
                            .offset(y: -150)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding()
                            .simultaneousGesture(TapGesture().onEnded{
                                self.notifyHandler.askPermission(date: self.selectedTime, type: "time", title: "Time to reflect", body: "Our app is here to help you keep track of your thoughts and emotions, and provide a safe space to express yourself freely.")
                            })
                        }
                        
                    }
                }//end VStack
                .offset(y: 49)
                .onAppear {
                    self.viewModel.isNotificationEnabled { isEnabled in
                        isToggled = isEnabled
                    }
                }
                
            }.ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
    }
}

struct myButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color("ReminderBox"))
            .foregroundColor(.white)
            .clipShape(Capsule())
            .font(.custom("Poppins-SemiBold", size: 14))
    }
}

