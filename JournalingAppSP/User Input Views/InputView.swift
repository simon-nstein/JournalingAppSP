//
//  InputView.swift
//  JournalingAppSP
//
//  Created by Paul McSlarrow on 3/7/23.
//

import SwiftUI
import Foundation

struct InputView: View {
    @ObservedObject var viewModel: JournalData;
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var type: String
    var headerText: String {
        switch self.type {
            case "ROSE": return "Highlight a success or something positive today."
            case "BUD": return "Describe a challenge you experienced today."
            case "THORN": return "Explain something that you’re looking forward to."
            case "OPEN": return "No rules. Just let your thoughts run."
            default: return "Default text"
        }
    }
    var pageNumber: String {
        switch self.type {
            case "ROSE": return "1 of 3 responses"
            case "BUD": return "2 of 3 responses"
            case "THORN": return "3 of 3 responses"
            default: return "Default text"
        }
    }
    
    
    @State var userInput = ""
    var body: some View {
        VStack(alignment: .leading) {
            Text(headerText)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color("darkColor"))
                .font(Font.custom("Poppins-SemiBold", size: CustomFontSize.largeFontSize))
        
            TextField(
                "Start Typing...",
                text: $userInput,
                axis: .vertical
            )
            .lineLimit(5...100)
            .padding()
            .font(Font.custom("Poppins-Regular", size: 24))
    
            // Saving data
            .onDisappear {
                if self.type == "ROSE" {
                    self.viewModel.roseInput = self.userInput
                    self.viewModel.addRose(with: self.userInput)
                }
            
            }
            .onAppear {
                if self.type == "ROSE" {
                    self.userInput = self.viewModel.getTodaysRose() ?? ""
                }
            }
            Spacer()
            Text(pageNumber)
                .padding(.leading, 20)
            
        }//VStack
        .font(Font.custom("Poppins-Medium", size: CustomFontSize.inputFontSize))
    }
}


struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(
            viewModel: JournalData(UserProfile: Profile.empty), type: "ROSE"
        )
        
    }
}
