//
//  GoalView.swift
//  JournalingAppSP
//
//  Created by Paul McSlarrow on 4/23/23.
//

import SwiftUI

struct GoalObject: View {
    let item: String
    @State var clicked = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(clicked ? Color.blue : CustomColor.lightButtonColor)
            .frame(height: 50)
            .overlay(TextView(text: item, fontSize: 15, offset: 0, fontType: "Poppins-Regular"))
            .onTapGesture {
                clicked.toggle()
            }
    }
}

struct GoalView: View {
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
            VStack {
                TextView(text: "Your Goal(s)", fontSize: 30, offset: 0, fontType: "Poppins-SemiBold").foregroundColor(.white)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(data, id: \.self) { item in
                            GoalObject(item: item)
                        }
                    }
                    .padding()
                }
                    
                TextField("Other...", text: $userTextField)
                        .frame(width: UIScreen.main.bounds.width * 0.925)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .fixedSize(horizontal: true, vertical: false)
                
                
                HStack {
                    Button("Remind me later") {
                        // handle remind me later
                    }.foregroundColor(.white)
                    
                        Spacer()
                    
                    Button("Submit") {
                        // handle submit
                    }.padding()
                }.padding()
            }.background(CustomColor.darkBackground)
        }
}

struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        GoalView()
    }
}
