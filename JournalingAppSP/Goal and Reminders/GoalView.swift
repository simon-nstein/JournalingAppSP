//
//  GoalView.swift
//  JournalingAppSP
//
//  Created by Paul McSlarrow on 4/23/23.
//

import SwiftUI

var array: [String] = []

struct GoalObject: View {
    let item: String
    @State var clicked = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(clicked ? CustomColor.activeButtonColor : CustomColor.lightButtonColor)
            .frame(height: 50)
            .overlay(TextView(text: item, fontSize: 15, offset: 0, fontType: "Poppins-Regular"))
            .onTapGesture {
                // If the button is clicked and you are turning it off, remove from array otherwise add to the array
                if (clicked) {
                    array.removeAll { $0 == item }
                } else {
                    array.append(item)
                }
                clicked.toggle()
            }
    }
}

struct GoalView: View {
    var viewModel: JournalData
    var userProfile: Profile

    let data = [
        "Reduce Anxiety",
        "Sleep Better",
        "Clear Mind",
        "Control Emotions",
        "Be More Confident",
        "Improve Habits",
        "Enhance focus",
        "Improve Creativity",
        "Improve Productivity",
        "For Fun",
        "Gratitude",
        "Self-care",
        "Breathing",
        "Positivity",
        "Mindful Eating",
        "Body Scan",
        "Visualization",
        "Journaling",
        "Sleep Hygiene",
        "Yoga Practice",
        "Stress Relief",
        "Mental Fitness",
        "Emotional Balance",
        "Healthy Habits"
    ]
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        
        @State var userTextField = ""
        var body: some View {
            NavigationView {
                VStack {
                    TextView(text: "Your Goal(s)", fontSize: 30, offset: 0, fontType: "Poppins-SemiBold").foregroundColor(.white)
                    
                    ScrollView {                                                        // Grid
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(data, id: \.self) { item in
                                GoalObject(item: item)
                            }
                        }
                        .padding()
                    }
                                            
                    TextField("Other...", text: $userTextField)                         // Textfield
                            .frame(width: UIScreen.main.bounds.width * 0.925)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .fixedSize(horizontal: true, vertical: false)
                    
                    
                    HStack {
                            NavigationLink(destination: ReminderView(viewModel: JournalData(UserProfile: self.userProfile), userProfile: self.userProfile)) {
                                Text("Remind me later")
                            }
                        
                            Spacer()
                        
                                                                                        // Submit button and Adding goals to database
                        NavigationLink(destination: ContentView(viewModel: JournalData(UserProfile: self.userProfile), userProfile: self.userProfile).onAppear {
                            self.viewModel.addGoal(goalsArray: array, textField: userTextField)
                        }) {
                            Text("Submit")
                        }

                        .foregroundColor(CustomColor.activeButtonColor)
                        .padding()
                    }.padding()
                }.background(CustomColor.darkBackground)
            }
            
        } // body
}

