//
//  WeekGlance.swift
//  JournalingAppSP
//
//  Created by Paul McSlarrow on 3/5/23.
//

import SwiftUI


struct GlanceView: View {
    let viewModel: JournalData
    @State private var selectedView = "Week"
    @State private var selectedButton = "Week"
    
    var body: some View {
        NavigationView {
            VStack{
                HStack(){
                    Button(action: {
                        self.selectedView = "Week"
                        self.selectedButton = "Week"
                    }) {
                        Text("Week")
                            .foregroundColor(selectedButton == "Week" ? Color("darkColor") : Color("veryLightColor"))
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        self.selectedView = "Month"
                        self.selectedButton = "Month"
                    }) {
                        Text("Month")
                            .foregroundColor(selectedButton == "Month" ? Color("darkColor") : Color("veryLightColor"))
                    }
                    Spacer()
                    
                    Button(action: {
                        self.selectedView = "SixMonths"
                        self.selectedButton = "SixMonths"
                    }) {
                        Text("6 Months")
                            .foregroundColor(selectedButton == "SixMonths" ? Color("darkColor") : Color("veryLightColor"))
                    }
                    Spacer()
                    
                    Button(action: {
                        self.selectedView = "Year"
                        self.selectedButton = "Year"
                    }) {
                        Text("Year")
                            .foregroundColor(selectedButton == "Year" ? Color("darkColor") : Color("veryLightColor"))
                    }
                }//end HStack
                .padding()
                if selectedView == "Week" {
                    //Text("Week")
                    WeekGlance(viewModel: self.viewModel)
                }
                if selectedView == "Month" {
                    Text("Month")
                }
                if selectedView == "SixMonths" {
                    Text("Six Months")
                }
                if selectedView == "Year" {
                    Text("Year")
                }
                Spacer()
            }//end VStack
            
        }//end NavView
        .font(Font.custom("Poppins-Regular", size: CustomFontSize.standardFontSize))
        .foregroundColor(Color("darkColor"))
        
        
        
        
        
        
        
        
        
        
    }//end of body
    
}

struct GlanceView_Previews: PreviewProvider {
    static var previews: some View {
        GlanceView(viewModel: JournalData(UserProfile: Profile.empty))
    }
}
