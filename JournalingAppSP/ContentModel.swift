//
//  ContentModel.swift
//  JournalingAppSP
//
//  Created by Paul McSlarrow on 3/3/23.
//

import Foundation

struct JournalModel {
    var messageType = "" // rose, bud, thorn
    var userMessage = ""  // the message the user types in for the card
    var dateEntered: Date?// Date optional for whether the user inputs anything
}
