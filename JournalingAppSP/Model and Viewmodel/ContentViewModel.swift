//
//  ContentViewModel.swift
//  JournalingAppSP
//
//  Created by Paul McSlarrow on 3/3/23.
//


import Foundation
import SwiftUI
import CoreData
import SwiftUI
import FirebaseCore
import FirebaseDatabase
import Firebase


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool { return true }
    
    func addNewUser(username: String) {
        let databaseRef = Database.database().reference()
        var DATE: String {
            return getTodaysDate()
        }
        let mindfulnessRef = databaseRef.child("Users/\(username)/Mindfulness_Section/\(DATE)")
        let gratitudeRef = databaseRef.child("Users/\(username)/Gratitude_Section/\(DATE)")
        let openRef = databaseRef.child("Users/\(username)/Open_Section/\(DATE)")

        mindfulnessRef.child("Rose").setValue(["Message":"", "Favorite": ""])   // Adds new sections for Rose, Bud, Thorn, Gratitude, Open Journal, and Notifications
        mindfulnessRef.child("Bud").setValue(["Message":"", "Favorite": ""])
        mindfulnessRef.child("Thorn").setValue(["Message":"", "Favorite": ""])
        gratitudeRef.child("Input1").setValue(["Message":"", "Favorite": ""])
        gratitudeRef.child("Input2").setValue(["Message":"", "Favorite": ""])
        gratitudeRef.child("Input3").setValue(["Message":"", "Favorite": ""])
        openRef.setValue(["userInput":"", "favorite":""])
        databaseRef.child("Users/\(username)/Notifications").setValue("false")
        print("New User Added [+]")
    }
    
    func userExists(username: String, completionHandler: @escaping (Bool) -> Void) {
        FirebaseApp.configure()
        let databaseRef = Database.database().reference()
        databaseRef.child("Users/").getData(completion:  { error, snapshot in
          guard error == nil else {
            print(error!.localizedDescription)
            return;
          }
            guard let value = snapshot?.value as? [String: Any] else { return }
            if let _ = value[username] as? [String: Any] {
                print("\(username) exists")
                completionHandler(true)
            } else {
                print("\(username) doesn't exist")
                completionHandler(false)
            }
        });
    }
}


/* JournalData ViewModel */
class JournalData: ObservableObject {
    @Published var model = JournalModel()
    @Published var savedRoses: [RoseObject] = []
    @Published var savedBuds: [BudObject] = []
    @Published var savedThorns: [ThornObject] = []
    @Published var savedOpens: [OpenObject] = []
    @Published var savedGratitudes: [GratitudeObject] = []
    
    @Published var test2: [RoseObject] = []
    
    @Published var weekRoses: [RoseObject] = []
    @Published var weekBuds: [BudObject] = []
    @Published var weekThorns: [ThornObject] = []
    @Published var weekOpens: [OpenObject] = []
    @Published var weekGratitudes: [GratitudeObject] = []
    
    @Published var monthRoses: [RoseObject] = []
    @Published var monthBuds: [BudObject] = []
    @Published var monthThorns: [ThornObject] = []
    @Published var monthOpens: [OpenObject] = []
    @Published var monthGratitudes: [GratitudeObject] = []

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    let UserProfile: Profile

    init (UserProfile: Profile) {
        self.UserProfile = UserProfile
        fetchRoses()
        fetchBuds()
        fetchThorns()
        fetchOpens()
        fetchGrat()
        //week()
    }
    
    
    /*
    func week(){
        let calendar = Calendar.current
        let currentDay = Date()
        let weekday = calendar.component(.weekday, from: Date())
        let weekRoses = []
        
        for i in (1..<weekday).reversed() {
            if let previousDay = calendar.date(byAdding: .day, value: -i, to: currentDay) {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let previousDate = dateFormatter.string(from: previousDay)
                
                //looping though saved roses
                for i in 0..<array.count {
                    //if date exists in saved roses
                    if array[i].dateID == previousDate {
                        weekRoses.append(["message": array[i].message, "favorite": array[i].favorite, "date": array[i].dateID])
                    }
                }
            } else {
                print("Invalid date")
            }
        }
    }
     */
    
    func addGoal(goalsArray: [String], textField: String) -> Void {
        let rootRef = Database.database().reference()
        let ref = rootRef.child("Users/\(self.UserProfile.id_string)")
        let path = "Goals/"
        
        // Adding array items
        for (_, element) in goalsArray.enumerated() {
            ref.child(path).childByAutoId().setValue(element)
        }
        
        // Adding text field
        if ( textField != "" ) {
            ref.child(path).childByAutoId().setValue(textField)
        }
        print("added new goals [+]")
    }
    
    
    /* ROSE FUNCTIONS */
    func fetchRoses() {
        print("Fetching a user rose for user \(self.UserProfile.id_string)")
        let rootRef = Database.database().reference()
        let ref = rootRef.child("Users/\(self.UserProfile.id_string)")
        ref.observe(.value, with: { snapshot in
          //print(snapshot.value as Any)
            if let data = snapshot.value as? [String: Any] {
                    if let mindfulnessSection = data["Mindfulness_Section"] as? [String: Any] {
                        for (dateString, dateSection) in mindfulnessSection {
                            if let currentDateSection = dateSection as? [String: Any],
                               let roseSection = currentDateSection["Rose"] as? [String: Any] {
                                
                                let roseFavorite = roseSection["Favorite"] as? String ?? ""  //print("roseFavorite", roseFavorite)
                                let roseMessage = roseSection["Message"] as? String ?? ""
                                
                                let roseObject = RoseObject(message: roseMessage, favorite: roseFavorite, dateID: dateString)
                                //print("Date: \(dateString), Rose Favorite: \(roseFavorite), Rose Message: \(roseMessage)")
                                self.savedRoses.append(roseObject)
                                
                            }
                        }
                    }
                }
        })
    }
    
    // Adds a new rose to the database
    func addRose(with message: String) {
        let stringDate = getTodaysDate()
        
        //Update existing roses
        for i in 0..<self.savedRoses.count {
            if self.savedRoses[i].dateID == stringDate {
                self.savedRoses[i].message = message
            }
        }
        //Updates the database
        let rootRef = Database.database().reference()
        let ref = rootRef.child("Users/\(self.UserProfile.id_string)")
        let path = "Mindfulness_Section/\(stringDate)/Rose/Message"
        ref.child(path).setValue(message)
        
        /*
        // auto setting favorite to be false
        let path = "Mindfulness_Section/\(stringDate)/Rose/Favorite"
        ref.child(path).setValue("false")
         */
        
        print("Added a new Rose [+]")
        fetchRoses()
    }
    
    func getTodaysRBT(with array: [RBTObject]) -> String? {
        let stringDate = getTodaysDate()
        
        for i in 0..<array.count {
            if array[i].dateID == stringDate {
                return array[i].message
            }
        }
        return nil
    }
    
    func getTodaysOpen(with array: [TheOpenObject]) -> String? {
        let stringDate = getTodaysDate()
        
        for i in 0..<array.count {
            if array[i].dateID == stringDate {
                return array[i].userInput
            }
        }
        return nil
    }
    
    func getTodaysGratitude(with array: [GratitudeObject], with whichInput: String) -> String? {
        let stringDate = getTodaysDate()
        
        for i in 0..<array.count {
            if array[i].dateID == stringDate {
                
                if whichInput == "Input1"{
                    return array[i].message1
                }
                if whichInput == "Input2"{
                    return array[i].message2
                }
                if whichInput == "Input3"{
                    return array[i].message3
                }
            }
        }
        return nil
    }

    
    /* BUD FUNCTIONS */
    func fetchBuds() {
        print("Fetching a user bud for user \(self.UserProfile.id_string)")
        let rootRef = Database.database().reference()
        let ref = rootRef.child("Users/\(self.UserProfile.id_string)")
        ref.observe(.value, with: { snapshot in
            if let data = snapshot.value as? [String: Any] {
                    if let mindfulnessSection = data["Mindfulness_Section"] as? [String: Any] {
                        for (dateString, dateSection) in mindfulnessSection {
                            if let currentDateSection = dateSection as? [String: Any],
                               let budSection = currentDateSection["Bud"] as? [String: Any] {
                                let budFavorite = budSection["Favorite"] as? String ?? ""
                                let budMessage = budSection["Message"] as? String ?? ""
                                let budObject = BudObject(message: budMessage, favorite: budFavorite, dateID: dateString)
                                //print("Date: \(dateString), Bud Favorite: \(budFavorite), Bud Message: \(budMessage)")
                                self.savedBuds.append(budObject)
                            }
                        }
                    }
                }
        })
    }
    
    // Adds a new rose to the database
    func addBud(with message: String) {
        let stringDate = getTodaysDate()
        
        //Update existing roses
        for i in 0..<self.savedBuds.count {
            if self.savedBuds[i].dateID == stringDate {
                self.savedBuds[i].message = message
            }
        }
        //Updates the database
        let rootRef = Database.database().reference()
        let ref = rootRef.child("Users/\(self.UserProfile.id_string)")
        let path = "Mindfulness_Section/\(stringDate)/Bud/Message"
        ref.child(path).setValue(message)
        
        /*
        // auto setting favorite to be false
        let path = "Mindfulness_Section/\(stringDate)/Bud/Favorite"
        ref.child(path).setValue("false")
         */
        
        print("Added a new Bud [+]")
        fetchBuds()
    }
    
                                                                    /* THORN FUNCTIONS*/
    func fetchThorns() {
        print("Fetching a user thorn for user \(self.UserProfile.id_string)")
        let rootRef = Database.database().reference()
        let ref = rootRef.child("Users/\(self.UserProfile.id_string)")
        ref.observe(.value, with: { snapshot in
            if let data = snapshot.value as? [String: Any] {
                    if let mindfulnessSection = data["Mindfulness_Section"] as? [String: Any] {
                        for (dateString, dateSection) in mindfulnessSection {
                            if let currentDateSection = dateSection as? [String: Any],
                               let thornSection = currentDateSection["Thorn"] as? [String: Any] {
                                let thornFavorite = thornSection["Favorite"] as? String ?? ""
                                let thornMessage = thornSection["Message"] as? String ?? ""
                                let thornObject = ThornObject(message: thornMessage, favorite: thornFavorite, dateID: dateString)
                                print("PRINT", thornObject)
                                //print("Date: \(dateString), Thorn Favorite: \(thornFavorite), Thorn Message: \(thornMessage)")
                                self.savedThorns.append(thornObject)
                            }
                        }
                    }
                }
        })
    }
    
    // Adds a new rose to the database
    func addThorn(with message: String) {
        let stringDate = getTodaysDate()
        
        //Update existing roses
        for i in 0..<self.savedThorns.count {
            if self.savedThorns[i].dateID == stringDate {
                self.savedThorns[i].message = message
            }
        }
        //Updates the database
        let rootRef = Database.database().reference()
        let ref = rootRef.child("Users/\(self.UserProfile.id_string)")
        let path = "Mindfulness_Section/\(stringDate)/Thorn/Message"
        ref.child(path).setValue(message)
        
        /*
        let path = "Mindfulness_Section/\(stringDate)/Thorn/Favoirte"
        ref.child(path).setValue("false")
         */
        
        
        print("Added a new Thorn [+]")
        fetchThorns()
    }
    
    func fetchOpens() {
        print("Fetching open data for user \(self.UserProfile.id_string)")
        let rootRef = Database.database().reference()
        let ref = rootRef.child("Users/\(self.UserProfile.id_string)/Open_Section")
        ref.observe(.value, with: { snapshot in
            if let data = snapshot.value as? [String: Any] {
                for (dateString, dateSection) in data {
                    if let currentDateSection = dateSection as? [String: Any] {
                        let openFavorite = currentDateSection["favorite"] as? String ?? ""
                        let openMessage = currentDateSection["userInput"] as? String ?? ""
                        let openObject = OpenObject(userInput: openMessage, favorite: openFavorite, dateID: dateString)
                        //print("openObject", openObject)
                        self.savedOpens.append(openObject)
                        //print("print(self.savedOpens)", self.savedOpens)
                    }
                }
            }
        })
    }
    
    
    // Adds a new OPEN to the database
    func addOpen(with message: String) {
        let stringDate = getTodaysDate()
        
        //Update existing roses
        for i in 0..<self.savedOpens.count {
            if self.savedOpens[i].dateID == stringDate {
                self.savedOpens[i].userInput = message
            }
        }
        //Updates the database
        let rootRef = Database.database().reference()
        let ref = rootRef.child("Users/\(self.UserProfile.id_string)")
        let path = "Open_Section/\(stringDate)/userInput"
        ref.child(path).setValue(message)
        
        print("Added a new Open [+]")
        fetchOpens()
    }
    
    func addFavoriteRose(stringDate: String){
        //add in what type, either Rose, Bud, or Thorn
        //NEW!!! NEW!!! NEW!!! NEW!!! NEW!!! NEW!!! NEW!!! NEW!!!
        
        //let stringDate = getTodaysDate()
        print("DATE", stringDate)
        var value = ""
        
        if Getfavorite(with: savedRoses, stringDate: stringDate) == "true" {
            value = "false"
        } else { //"false" or ""
            value = "true"
        }
        
        //Update savedRoses
        for i in 0..<self.savedRoses.count {
            if self.savedRoses[i].dateID == stringDate {
                self.savedRoses[i].favorite = value
            }
        }
        //Updates the database
        let rootRef = Database.database().reference()
        let ref = rootRef.child("Users/\(self.UserProfile.id_string)")
        let path = "Mindfulness_Section/\(stringDate)/Rose/Favorite"
        ref.child(path).setValue(value)
    }
    
    func addFavoriteBud(stringDate: String){
        //add in what type, either Rose, Bud, or Thorn
        //NEW!!! NEW!!! NEW!!! NEW!!! NEW!!! NEW!!! NEW!!! NEW!!!
        
        //let stringDate = getTodaysDate()
        print("DATE", stringDate)
        var value = ""
        
        if Getfavorite(with: savedBuds, stringDate: stringDate) == "true" {
            value = "false"
        } else { //"false" or ""
            value = "true"
        }
        
        //Update savedBuds
        for i in 0..<self.savedBuds.count {
            if self.savedBuds[i].dateID == stringDate {
                self.savedBuds[i].favorite = value
            }
        }
        //Updates the database
        let rootRef = Database.database().reference()
        let ref = rootRef.child("Users/\(self.UserProfile.id_string)")
        let path = "Mindfulness_Section/\(stringDate)/Bud/Favorite"
        ref.child(path).setValue(value)
    }
    
    
    func addFavoriteThorn(stringDate: String){
        //add in what type, either Rose, Bud, or Thorn
        //NEW!!! NEW!!! NEW!!! NEW!!! NEW!!! NEW!!! NEW!!! NEW!!!
        
        //let stringDate = getTodaysDate()
        print("DATE", stringDate)
        var value = ""
        
        if Getfavorite(with: savedThorns, stringDate: stringDate) == "true" {
            value = "false"
        } else { //"false" or ""
            value = "true"
        }
        
        //Update savedBuds
        for i in 0..<self.savedThorns.count {
            if self.savedThorns[i].dateID == stringDate {
                self.savedThorns[i].favorite = value
            }
        }
        //Updates the database
        let rootRef = Database.database().reference()
        let ref = rootRef.child("Users/\(self.UserProfile.id_string)")
        let path = "Mindfulness_Section/\(stringDate)/Thorn/Favorite"
        ref.child(path).setValue(value)
    }
    
     
    func Getfavorite(with array: [RBTObject], stringDate: String) -> String? {
        //getTodaysRose modified
        //let stringDate = getTodaysDate()
        for i in 0..<array.count {
            if array[i].dateID == stringDate {
                //print("GETFAV", array[i].favorite)
                //print("GetFavorite", array[i].favorite)
                return array[i].favorite
            }
        }
        return nil
        //HOW TO USE: self.viewModel.GetfavoriteRose(with: self.viewModel.savedRoses))
        //CHANGE savedRoses
    }
    
    
    func getRBT(with array: [RBTObject], stringDate: String) -> [String: String]? {
        //gets the message and favorite for a specific day
        //depends on which array you pass in - savedRoses - savedBuds - savedThorns
        for i in 0..<array.count {
            if array[i].dateID == stringDate {
                //print("GETFAV", array[i].favorite)
                //print("GetFavorite", array[i].favorite)
                //return array[i].favorite
                return ["message": array[i].message, "favorite": array[i].favorite]
            }
        }
        return nil
    }
    
    //OPEN
    func getOpen(with array: [TheOpenObject], stringDate: String) -> [String: String]? {
        //gets the message and favorite for a specific day
        //depends on which array you pass in - savedRoses - savedBuds - savedThorns
        for i in 0..<array.count {
            if array[i].dateID == stringDate {
                return ["message": array[i].userInput, "favorite": array[i].favorite]
            }
        }
        return nil
    }
    
    func addFavoriteOpen(stringDate: String){
        //NEW!!! NEW!!! NEW!!! NEW!!! NEW!!! NEW!!! NEW!!! NEW!!!
        
        //let stringDate = getTodaysDate()
        //print("DATE", stringDate)
        var value = ""
        
        if getOpen(with: savedOpens, stringDate: stringDate)?["favorite"] == "true" {
            value = "false"
        } else { //"false" or ""
            value = "true"
        }
        
        //Update savedBuds
        for i in 0..<self.savedOpens.count {
            if self.savedOpens[i].dateID == stringDate {
                self.savedOpens[i].favorite = value
            }
        }
        //Updates the database
        let rootRef = Database.database().reference()
        let ref = rootRef.child("Users/\(self.UserProfile.id_string)")
        let path = "Open_Section/\(stringDate)/favorite"
        ref.child(path).setValue(value)
    }
    
    //@Published var savedGratitudes: [GratitudeObject] = []
    func fetchGrat() {
        print("Fetching a user grat for user \(self.UserProfile.id_string)")
        let rootRef = Database.database().reference()
        let ref = rootRef.child("Users/\(self.UserProfile.id_string)")
        ref.observe(.value, with: { snapshot in
          //print(snapshot.value as Any)
            if let data = snapshot.value as? [String: Any] {
                    if let gratitudeSection = data["Gratitude_Section"] as? [String: Any] {
                        for (dateString, dateSection) in gratitudeSection {
                            if let currentDateSection = dateSection as? [String: Any],
                               let input1Section = currentDateSection["Input1"] as? [String: Any],
                               let input2Section = currentDateSection["Input2"] as? [String: Any],
                               let input3Section = currentDateSection["Input3"] as? [String: Any] {
                                
                                let input1Favorite = input1Section["Favorite"] as? String ?? ""
                                let input1Message = input1Section["Message"] as? String ?? ""
                                let input2Favorite = input2Section["Favorite"] as? String ?? ""
                                let input2Message = input2Section["Message"] as? String ?? ""
                                let input3Favorite = input3Section["Favorite"] as? String ?? ""
                                let input3Message = input3Section["Message"] as? String ?? ""
                                
                                let gratObject = GratitudeObject(dateID: dateString, message1: input1Message, favorite1: input1Favorite, message2: input2Message, favorite2: input2Favorite, message3: input3Message, favorite3: input3Favorite)
                                //print("Date: \(dateString), Rose Favorite: \(roseFavorite), Rose Message: \(roseMessage)")
                                self.savedGratitudes.append(gratObject)
                            }
                        }
                    }
                }
        })
    }
    
    func addGrat(message: String, whichInput: String) {
        //whichInput is either 'Input1', 'Input2', 'Input3'
        let stringDate = getTodaysDate()
        
        //Update existing grats
        if whichInput == "Input1"{
            for i in 0..<self.savedGratitudes.count {
                if self.savedGratitudes[i].dateID == stringDate {
                    self.savedGratitudes[i].message1 = message
                }
            }
        }
        if whichInput == "Input2"{
            for i in 0..<self.savedGratitudes.count {
                if self.savedGratitudes[i].dateID == stringDate {
                    self.savedGratitudes[i].message2 = message
                }
            }
        }
        if whichInput == "Input3"{
            for i in 0..<self.savedGratitudes.count {
                if self.savedGratitudes[i].dateID == stringDate {
                    self.savedGratitudes[i].message3 = message
                }
            }
        }
        
        //Updates the database
        let rootRef = Database.database().reference()
        let ref = rootRef.child("Users/\(self.UserProfile.id_string)")
        let path = "Gratitude_Section/\(stringDate)/\(whichInput)/Message"
        ref.child(path).setValue(message)
        
        print("Added a new Grat [+]")
        fetchGrat()
    }
    
    
    func getGrat(array: [TheGratitudeObject], stringDate: String, whichInput: String) -> [String: String]? {
        //gets the message and favorite for a specific day
        for i in 0..<array.count {
            if array[i].dateID == stringDate {
                if whichInput == "Input1"{
                    return ["message": array[i].message1, "favorite": array[i].favorite1]
                }
                if whichInput == "Input2"{
                    return ["message": array[i].message2, "favorite": array[i].favorite2]
                }
                if whichInput == "Input3"{
                    return ["message": array[i].message3, "favorite": array[i].favorite3]
                }
            }
        }
        return nil
    }
    
    func addFavoriteGrat(stringDate: String, whichInput: String){
        //NEW!!! NEW!!! NEW!!! NEW!!! NEW!!! NEW!!! NEW!!! NEW!!!
        
        print("HERE", getGrat(array: savedGratitudes, stringDate: stringDate, whichInput: whichInput)?["favorite"] ?? "")
        
        var value = ""
        
        if getGrat(array: savedGratitudes, stringDate: stringDate, whichInput: whichInput)?["favorite"] == "true" {
            value = "false"
        } else { //"false" or ""
            value = "true"
        }
        
        //Update savedBuds
        for i in 0..<self.savedOpens.count {
            if self.savedOpens[i].dateID == stringDate {
                
                if whichInput == "Input1"{
                    self.savedGratitudes[i].favorite1 = value
                }
                
                if whichInput == "Input2"{
                    self.savedGratitudes[i].favorite2 = value
                }
                
                if whichInput == "Input3"{
                    self.savedGratitudes[i].favorite3 = value
                }
            }
        }
        //Updates the database
        let rootRef = Database.database().reference()
        let ref = rootRef.child("Users/\(self.UserProfile.id_string)")
        let path = "Gratitude_Section/\(stringDate)/\(whichInput)/Favorite"
        ref.child(path).setValue(value)
    }
    
    
    func getWeekRBT(array: [RBTObject]) -> [[String: Any]]{
        //returns an array of either Roses, Buds, OR Thorns
        let calendar = Calendar.current
        let currentDay = Date()
        let weekday = calendar.component(.weekday, from: Date())
        var weekRBT = [[String: Any]]()
        
        for i in (0..<weekday).reversed() {
            if let previousDay = calendar.date(byAdding: .day, value: -i, to: currentDay) {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let previousDate = dateFormatter.string(from: previousDay)
                
                //looping though saved roses
                for i in 0..<array.count {
                    //if date exists in saved roses
                    if array[i].dateID == previousDate {
                        //print("array[i]", array[i])
                        weekRBT.append(["message": array[i].message, "favorite": array[i].favorite, "date": array[i].dateID])
                        //weekRBT.append(array[i])
                    }
                }
            } else {
                print("Invalid date")
            }
        }
        
        //print("getWeekRoses", weekRBT)
        return weekRBT
    }
    
    func getMonthRBT(array: [RBTObject]) -> [[String: Any]]{
        //returns an array of either Roses, Buds, OR Thorns
        let calendar = Calendar.current
        let currentDay = Date()
        let month = calendar.component(.month, from: currentDay)
        let year = calendar.component(.year, from: currentDay)
        let range = calendar.range(of: .day, in: .month, for: currentDay)!
        let numDays = range.count
        var monthRBT = [[String: Any]]()
        
        for i in 1...numDays {
            if let currentDay = calendar.date(from: DateComponents(year: year, month: month, day: i)) {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let currentDate = dateFormatter.string(from: currentDay)
                
                //looping though saved roses
                for i in 0..<array.count {
                    //if date exists in saved roses
                    if array[i].dateID == currentDate {
                        monthRBT.append(["message": array[i].message, "favorite": array[i].favorite, "date": array[i].dateID])
                    }
                }
            } else {
                print("Invalid date")
            }
        }
        
        return monthRBT
    }
    
    
    func getWeekGRAT() -> [[String: Any]]{
        let array = savedGratitudes
        let calendar = Calendar.current
        let currentDay = Date()
        let weekday = calendar.component(.weekday, from: Date())
        var weekGRAT = [[String: Any]]()
        
        for i in (0..<weekday).reversed() {
            if let previousDay = calendar.date(byAdding: .day, value: -i, to: currentDay) {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let previousDate = dateFormatter.string(from: previousDay)
                
                //looping though saved roses
                for i in 0..<array.count {
                    //if date exists in saved roses
                    if array[i].dateID == previousDate {
                        //print("array[i]", array[i])
                        //let gratObject = GratitudeObject(dateID: dateString, message1: input1Message, favorite1: input1Favorite, message2: input2Message, favorite2: input2Favorite, message3: input3Message, favorite3: input3Favorite)
                        weekGRAT.append(["message1": array[i].message1, "favorite1": array[i].favorite1, "message2": array[i].message2, "favorite2": array[i].favorite2, "message3": array[i].message3, "favorite3": array[i].favorite3,"date": array[i].dateID])
                        //weekRBT.append(array[i])
                    }
                }
            } else {
                print("Invalid date")
            }
        }
        
        //print("getWeekRoses", weekRBT)
        return weekGRAT
    }
    
    func getMonthGRAT() -> [[String: Any]]{
        let array = savedGratitudes
        let calendar = Calendar.current
        let currentDay = Date()
        let month = calendar.component(.month, from: currentDay)
        let year = calendar.component(.year, from: currentDay)
        let range = calendar.range(of: .day, in: .month, for: currentDay)!
        let numDays = range.count
        var monthGRAT = [[String: Any]]()
        
        for i in 1...numDays {
            if let currentDay = calendar.date(from: DateComponents(year: year, month: month, day: i)) {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let currentDate = dateFormatter.string(from: currentDay)
                
                //looping though saved roses
                for i in 0..<array.count {
                    //if date exists in saved roses
                    if array[i].dateID == currentDate {
                        monthGRAT.append(["message1": array[i].message1, "favorite1": array[i].favorite1, "message2": array[i].message2, "favorite2": array[i].favorite2, "message3": array[i].message3, "favorite3": array[i].favorite3,"date": array[i].dateID])
                    }
                }
            } else {
                print("Invalid date")
            }
        }
        
        return monthGRAT
    }
    
    func getWeekOPEN() -> [[String: Any]]{
        let array = savedOpens
        let calendar = Calendar.current
        let currentDay = Date()
        let weekday = calendar.component(.weekday, from: Date())
        var weekOPEN = [[String: Any]]()
        
        for i in (0..<weekday).reversed() {
            if let previousDay = calendar.date(byAdding: .day, value: -i, to: currentDay) {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let previousDate = dateFormatter.string(from: previousDay)
                
                //looping though saved roses
                for i in 0..<array.count {
                    //if date exists in saved roses
                    if array[i].dateID == previousDate {
                        print("IN", array[i])
                        weekOPEN.append(["userInput": array[i].userInput, "favorite": array[i].favorite, "date": array[i].dateID])
                        //weekRBT.append(array[i])
                    }
                }
            } else {
                print("Invalid date")
            }
        }
        
        //print("getWeekRoses", weekRBT)
        return weekOPEN
    }
    
    func getMonthOPEN() -> [[String: Any]]{
        let array = savedOpens
        let calendar = Calendar.current
        let currentDay = Date()
        let month = calendar.component(.month, from: currentDay)
        let year = calendar.component(.year, from: currentDay)
        let range = calendar.range(of: .day, in: .month, for: currentDay)!
        let numDays = range.count
        var monthOPEN = [[String: Any]]()
        
        for i in 1...numDays {
            if let currentDay = calendar.date(from: DateComponents(year: year, month: month, day: i)) {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let currentDate = dateFormatter.string(from: currentDay)
                
                //looping though saved roses
                for i in 0..<array.count {
                    //if date exists in saved roses
                    if array[i].dateID == currentDate {
                        monthOPEN.append(["userInput": array[i].userInput, "favorite": array[i].favorite, "date": array[i].dateID])
                    }
                }
            } else {
                print("Invalid date")
            }
        }
        
        return monthOPEN
    }
    
    
    
    
    /* Variables and Functions */
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
    
    var openInput: String {
        get { return model.openInput }
        set { model.openInput = newValue }
    }
    
    var gratitude1Input: String {
        get { return model.gratitude1Input }
        set { model.gratitude1Input = newValue }
    }
    
    var gratitude2Input: String {
        get { return model.gratitude2Input }
        set { model.gratitude2Input = newValue }
    }
    
    var gratitude3Input: String {
        get { return model.gratitude3Input }
        set { model.gratitude3Input = newValue }
    }
    
    var dateEntered: Date? {
        model.dateEntered
    }
    
    var greeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 0..<12:
            return "Good Morning"
        case 12..<18:
            return "Good Afternoon"
        default:
            return "Good Evening"
        }
    }
}

func getTodaysDate() -> String {
    let today = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.string(from: today)
}







                                                                /* Custom Fonts and Colors */
struct CustomColor {
    static let RoseColor = Color("RoseColor")
    static let BudColor = Color("BudColor")
    static let ThornColor = Color("ThornColor")
    static let TextColor = Color("TextColor")
    static let darkBlue = Color("darkBlue")
    static let darkButtonColor = Color("darkButtonColor")
    static let mindfulnessBackground = Color("mindfulnessBackground")
    static let darkTextColor = Color("darkTextColor")
    static let subtextColor = Color("subtextColor")
    static let gratitudeBackground = Color("gratitudeBackground")
    static let openJournalBackground = Color("openJournalBackground")
    static let heartRed = Color("HeartRed")
    static let darkBackground = Color("darkBackground")
    static let lightButtonColor = Color("lightButtonColor")
    static let activeButtonColor = Color("activeButtonColor")
    static let reminderBackground = Color("reminderBackground")
    static let reminderInsideBackground = Color("reminderInsideBackground")
}

struct CustomFontSize {
    static let tinyFontSize: CGFloat = 8;
    static let smallFontSize: CGFloat = 12;
    static let standardFontSize: CGFloat = 15;
    static let inputFontSize: CGFloat = 22;
    static let largeFontSize: CGFloat = 30;
    static let extraLargeFont: CGFloat = 40;
}

class NotificationHandler {
    func askPermission(date: Date, type: String, timeInterval: Double=10, title: String, body: String) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("Permission granted")
                self.sendNotification(date: date, type: type, title: title, body: body)
            } else {
                print("Permission denied")
                return
            }
        }
    }
    
    func sendNotification(date: Date, type: String, timeInterval: Double=10, title: String, body: String) {
        var trigger: UNNotificationTrigger?
        
        if type == "date" {
            let dateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: date)
            trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        } else if type == "time" {
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        }
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}
