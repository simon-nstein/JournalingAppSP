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
    static let tinyFontSize: CGFloat = 8;
    static let smallFontSize: CGFloat = 12;
    static let standardFontSize: CGFloat = 15;
    static let largeFontSize: CGFloat = 30;
    static let extraLargeFont: CGFloat = 40;
}

class JournalData: ObservableObject {
    @Published var model = JournalModel()
    
    // Variables
    var roseInput: String {
        get { return model.roseInput }
        set { model.roseInput = newValue }
    }
    
    var budInput: String {
        get { return model.budInput }
        set { model.budInput = newValue }
    }
    
    var thornInput: String {
        get { return model.thornInput }
        set { model.thornInput = newValue }
        
    }
    
    var dateEntered: Date? {
        model.dateEntered
    }
    

    // Intents (functions for interaction between UI and backend)
}
