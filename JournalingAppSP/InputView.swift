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
    var type: String
    var headerText: String {
        switch self.type {
            case "ROSE": return "Highlight a success, small win, or something positive that happened today or that you are planning for today."
            case "BUD": return "A challenge you experienced or something you can use more support with."
            case "THORN": return "New ideas that have blossomed or something you are looking forward to knowing more about or experiencing."
            default: return "Default text"
        }
    }
    
    @State var userInput = ""
    var body: some View {
        VStack {
            Text(headerText)
                .padding(.leading)
                .foregroundColor(CustomColor.TextColor)
        
            TextField(
                "Start Typing...",
                text: $userInput,
                axis: .vertical
            )
            .lineLimit(5...100)
            .padding()
    
            // Saving the data
            .onChange(of: userInput) {
                if self.type == "ROSE" {
                    self.viewModel.roseInput = $0
                    self.viewModel.addRose(with: $0)
                }
                
                if self.type == "BUD" {
                    self.viewModel.budInput = $0
                    self.viewModel.addBud(with: $0)
                }
                
                if self.type == "THORN" {
                    self.viewModel.thornInput = $0
                    self.viewModel.addThorn(with: $0)
                }
                self.viewModel.saveData()
            }
            .onAppear {
                if self.type == "ROSE" {
                    self.userInput = self.viewModel.getTodaysRose() ?? ""
                }
                
                if self.type == "BUD" {
                    self.userInput = self.viewModel.getTodaysBud() ?? ""
                }
                
                if self.type == "THORN" {
                    self.userInput = self.viewModel.getTodaysThorn() ?? ""
                }
                
            }
            
            Spacer()
            Image(systemName: "mic.circle.fill")
                .offset(y: -20)
                .font(.system(size: 60))
                .foregroundColor(.black)
        }
        .offset(y: 40)
        .font(Font.custom("Poppins-Medium", size: CustomFontSize.inputFontSize))
        
    }
}


struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(
            viewModel: JournalData(), type: "ROSE"
        )
        
    }
}
