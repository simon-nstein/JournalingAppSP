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
