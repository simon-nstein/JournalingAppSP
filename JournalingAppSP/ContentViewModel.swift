//
//  ContentViewModel.swift
//  JournalingAppSP
//
//  Created by Paul McSlarrow on 3/3/23.
//

import Foundation
import SwiftUI


struct CustomColor {
    static let RoseColor = Color("RoseColor")
    static let BudColor = Color("BudColor")
    static let ThornColor = Color("ThornColor")
    static let TextColor = Color("TextColor")
}

struct CustomFontSize {
    static let smallFontSize: CGFloat = 12;
    static let standardFontSize: CGFloat = 15;
    static let largeFontSize: CGFloat = 30;
    static let extraLargeFont: CGFloat = 40;
}

class JournalData: ObservableObject {
    @Published var model = JournalModel()
    
    // Variables
    var messageType: String {
        model.messageType
    }
    
    var userMessage: String {
        model.userMessage
    }
    
    var dateEntered: Date? {
        model.dateEntered
    }
    

    // Intents (functions for interaction between UI and backend)
}
