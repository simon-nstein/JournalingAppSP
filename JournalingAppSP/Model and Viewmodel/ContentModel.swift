//
//  ContentModel.swift
//  JournalingAppSP
//
//  Created by Paul McSlarrow on 3/3/23.
//

import Foundation
import JWTDecode

struct JournalModel {
    var roseInput = ""
    var budInput  = ""
    var thornInput = ""
    var openInput = ""
    var gratitude1Input = ""
    var gratitude2Input = ""
    var gratitude3Input = ""
    var dateEntered: Date?
    var greeting = ""
    
}


/*  Model for login system  */
struct Profile {
    let id: String
    let name: String
    let email: String
    let emailVerified: String
    let picture: String
    let updatedAt: String
    let id_string: String
}

extension Profile {
  
    static var empty: Self {
        return Profile(
          id: "",
          name: "",
          email: "",
          emailVerified: "",
          picture: "",
          updatedAt: "",
          id_string: ""
        )
    }
    
    static func from(_ idToken: String) -> Self {
        guard
            let jwt = try? decode(jwt: idToken),
            let id = jwt.subject,
            let name = jwt.claim(name: "name").string,
            let email = jwt.claim(name: "email").string,
            let emailVerified = jwt.claim(name: "email_verified").boolean,
            let picture = jwt.claim(name: "picture").string,
            let updatedAt = jwt.claim(name: "updated_at").string
        else {
            return .empty
        }
        
        var ID_STRING: String {
            let str = id
            let startIndex = str.index(str.startIndex, offsetBy: 6)
            let substr = str[startIndex...]
            let user = String(substr)
            return user
        }
    
        
        return Profile(
            id: id,
            name: name,
            email: email,
            emailVerified: String(describing: emailVerified),
            picture: picture,
            updatedAt: updatedAt,
            id_string: ID_STRING
        )
    }
    
}

protocol RBTObject {
    var dateID: String { get }
    var message: String { get }
    var favorite: String { get }
}

protocol TheOpenObject {
    var dateID: String { get }
    var userInput: String { get }
    var favorite: String { get }
}

protocol TheGratitudeObject {
    var dateID: String { get }
    var message1: String { get }
    var favorite1: String { get }
    var message2: String { get }
    var favorite2: String { get }
    var message3: String { get }
    var favorite3: String { get }
}

struct RoseObject: Hashable, RBTObject {
    var message: String
    var favorite: String
    var dateID: String
}

struct BudObject: Hashable, RBTObject {
    var message: String
    var favorite: String
    var dateID: String
}

struct ThornObject: Hashable, RBTObject {
    var message: String
    var favorite: String
    var dateID: String
}


struct OpenObject: Hashable, TheOpenObject {
    var userInput: String
    var favorite: String
    var dateID: String
}

struct GratitudeObject: Hashable, TheGratitudeObject {
    var dateID: String
    var message1: String
    var favorite1: String
    var message2: String
    var favorite2: String
    var message3: String
    var favorite3: String
}


