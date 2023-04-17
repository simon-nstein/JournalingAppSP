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
            default: return ""
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
                switch self.type {
                    case "ROSE":
                        self.viewModel.roseInput = self.userInput
                        self.viewModel.addRose(with: self.userInput)
                    case "BUD":
                        self.viewModel.budInput = self.userInput
                        self.viewModel.addBud(with: self.userInput)
                    case "THORN":
                        self.viewModel.thornInput = self.userInput
                        self.viewModel.addThorn(with: self.userInput)
                    case "OPEN":
                        self.viewModel.openInput = self.userInput
                        self.viewModel.addOpen(with: self.userInput)
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

                    default:
                        break;
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
