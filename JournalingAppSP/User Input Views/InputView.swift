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
            case "GRAT1": return "I am most grateful for..."
            case "GRAT2": return "I am most grateful for..."
            case "GRAT3": return "I am most grateful for..."
            
            default: return "Default text"
        }
    }
    var pageNumber: String {
        switch self.type {
            case "ROSE": return "1 of 3 responses"
            case "BUD": return "2 of 3 responses"
            case "THORN": return "3 of 3 responses"
            
            case "GRAT1": return "1 of 3 responses"
            case "GRAT2": return "2 of 3 responses"
            case "GRAT3": return "3 of 3 responses"
            default: return ""
        }
    }
    
    
    @State var userInput = ""
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(headerText)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color("HeaderColor"))
                .font(Font.custom("Poppins-SemiBold", size: CustomFontSize.largeFontSize))
            
            TextField(
                "Start Typing...",
                text: $userInput,
                axis: .vertical
            )
            .lineLimit(5...100)
            .padding()
            .font(Font.custom("Poppins-Regular", size: 24))
            //.foregroundColor(Color("StartTypingColor"))
            
            // Saving data
            .onDisappear {
                switch self.type {
                case "ROSE":
                    //only saves if they type something
                    if self.userInput != "" {
                        self.viewModel.roseInput = self.userInput
                        self.viewModel.addRose(with: self.userInput)
                        //NEW STREAK
                        self.viewModel.addStreak()
                        //self.viewModel.addRBT(message: self.userInput, path: "Rose", savedType: &viewModel.savedBuds)
                    }
                case "BUD":
                    //only saves if they type something
                    if self.userInput != "" {
                        self.viewModel.budInput = self.userInput
                        self.viewModel.addBud(with: self.userInput)
                    }
                    
                case "THORN":
                    if self.userInput != "" {
                        self.viewModel.thornInput = self.userInput
                        self.viewModel.addThorn(with: self.userInput)
                    }
                case "OPEN":
                    if self.userInput != "" {
                        self.viewModel.openInput = self.userInput
                        self.viewModel.addOpen(with: self.userInput)
                        //NEW STREAK
                        self.viewModel.addStreak()
                    }
                    
                    
                    //NEED TO CHANGE
                case "GRAT1":
                    if self.userInput != "" {
                        self.viewModel.gratitude1Input = self.userInput
                        self.viewModel.addGrat(message: self.userInput, whichInput: "Input1")
                        //NEW STREAK
                        self.viewModel.addStreak()
                    }
                case "GRAT2":
                    if self.userInput != "" {
                        self.viewModel.gratitude2Input = self.userInput
                        self.viewModel.addGrat(message: self.userInput, whichInput: "Input2")
                    }
                case "GRAT3":
                    if self.userInput != "" {
                        self.viewModel.gratitude3Input = self.userInput
                        self.viewModel.addGrat(message: self.userInput, whichInput: "Input3")
                    }
                    
                default:
                    break;
                }
                
                
            }
            .onAppear {
                switch self.type {
                case "ROSE":
                    self.userInput = self.viewModel.getTodaysRBT(with: self.viewModel.savedRoses) ?? ""
                    
                case "BUD":
                    self.userInput = self.viewModel.getTodaysRBT(with: self.viewModel.savedBuds) ?? ""
                    
                case "THORN":
                    self.userInput = self.viewModel.getTodaysRBT(with: self.viewModel.savedThorns) ?? ""
                    
                case "OPEN":
                    self.userInput = self.viewModel.getTodaysOpen(with: self.viewModel.savedOpens) ?? ""
                    
                    //NEED TO CHANGE
                case "GRAT1":
                    self.userInput = self.viewModel.getTodaysGratitude(with: self.viewModel.savedGratitudes, with: "Input1") ?? ""
                    
                case "GRAT2":
                    self.userInput = self.viewModel.getTodaysGratitude(with: self.viewModel.savedGratitudes, with: "Input2") ?? ""
                    
                case "GRAT3":
                    self.userInput = self.viewModel.getTodaysGratitude(with: self.viewModel.savedGratitudes, with: "Input3") ?? ""
                    
                default:
                    break;
                }
            }
            Spacer()
            
        }//VStack
        .font(Font.custom("Poppins-Medium", size: CustomFontSize.inputFontSize))
        .background(Color("NEWbackground"))
    }
}


struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(
            viewModel: JournalData(UserProfile: Profile.empty), type: "ROSE"
        )
        
    }
}
