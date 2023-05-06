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
        
        //let streakRef = databaseRef.child("Users/\(username)/Streak").setValue(["date": DATE])
        
        

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
    
    
    @Published var savedStreaks: [StreakObject] = []

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    let UserProfile: Profile

    init (UserProfile: Profile) {
        self.UserProfile = UserProfile
        fetchRoses()
        fetchBuds()
        fetchThorns()
        fetchOpens()
        fetchGrat()
        //isDateInCurrentWeek(dateString: "2023-04-01")
        //week()
        getStreak()
        
    }


    func enableNotification() {
        let rootRef = Database.database().reference()
        let ref = rootRef.child("Users/\(self.UserProfile.id_string)")
        let path = "Notifications/"
        ref.child(path).setValue("true")
    }
    
    func disableNotification() {
        let rootRef = Database.database().reference()
        let ref = rootRef.child("Users/\(self.UserProfile.id_string)")
        let path = "Notifications/"
        ref.child(path).setValue("false")
    }
    
    func isNotificationEnabled(completion: @escaping (Bool) -> Void) {
        let rootRef = Database.database().reference()
        let ref = rootRef.child("Users/\(self.UserProfile.id_string)")
        
        ref.observe(.value, with: { snapshot in
            if let data = snapshot.value as? [String: Any] {
                if let notificationSelection = data["Notifications"] as? String {
                    completion(notificationSelection == "true")
                } else {
                    print("Error getting notification")
                    completion(false)
                }
            }
        })
    }
    
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
        //print("Fetching a user rose for user \(self.UserProfile.id_string)")
        let rootRef = Database.database().reference()
        let ref = rootRef.child("Users/\(self.UserProfile.id_string)")
        ref.observe(.value, with: { snapshot in
            if let data = snapshot.value as? [String: Any] {
                    if let mindfulnessSection = data["Mindfulness_Section"] as? [String: Any] {
                        for (dateString, dateSection) in mindfulnessSection {
                            if let currentDateSection = dateSection as? [String: Any],
                               let roseSection = currentDateSection["Rose"] as? [String: Any] {
                                
                                let roseFavorite = roseSection["Favorite"] as? String ?? ""  //print("roseFavorite", roseFavorite)
                                let roseMessage = roseSection["Message"] as? String ?? ""
                                
                                let roseObject = RoseObject(message: roseMessage, favorite: roseFavorite, dateID: dateString)
                                //print("Date: \(dateString), Rose Favorite: \(roseFavorite), Rose Message: \(roseMessage)")
                                if !(self.savedRoses.contains(roseObject)) {
                                    self.savedRoses.append(roseObject)
                                }
                                
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
        
        print("Added/Updating a new Rose [+]")
        fetchRoses()
    }
    
    func addStreak() {
        let stringDate = getTodaysDate()
        
        if !self.savedStreaks.contains(StreakObject(dateID: stringDate)) {
            self.savedStreaks.append(StreakObject(dateID: stringDate))
        }
        
        print("Added New Streak [+]")
    }
    
    //
    
    func getStreak() -> Int {
        let today = Date()
        var count = 0
        let dateFormatter = DateFormatter()
        
        for i in 0..<self.savedStreaks.count {
            let yesterday = Calendar.current.date(byAdding: .day, value: -i, to: today)!
            let dateString = dateFormatter.string(from: yesterday)
            for j in 0..<self.savedStreaks.count {
                if savedStreaks[j].dateID == dateString {
                    count += 1
                }else{
                    return count
                }
            }
        }
        return count
    }
    
    func getPeriodStreak(period: String) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let calendar = Calendar.current
        let currentDate = Date()
        var count = 0
        if period == "week"{
            print("self.savedStreaks", self.savedStreaks)
            let currentWeek = calendar.component(.weekOfYear, from: currentDate)
            print("currentWeek", currentWeek)
            for i in 0..<self.savedStreaks.count {
                print("self.savedStreaks", self.savedStreaks)
                if let Datedate = dateFormatter.date(from: savedStreaks[i].dateID) {
                    print("Datedate", Datedate)
                    let givenWeek = calendar.component(.weekOfYear, from: Datedate)
                    if currentWeek == givenWeek{ count += 1 }
                }
            }
        }
        
        if period == "month"{
            let currentMonth = calendar.component(.month, from: currentDate)
            
            for i in 0..<self.savedStreaks.count {
                
                if let Datedate = dateFormatter.date(from: savedStreaks[i].dateID) {
                    let givenMonth = calendar.component(.month, from: Datedate)
                    if currentMonth == givenMonth{ count += 1 }
                }
                
            }
        }
        
        if period == "year" {
            let currentYear = calendar.component(.year, from: currentDate)
            
            for i in 0..<self.savedStreaks.count {
                if let date = dateFormatter.date(from: savedStreaks[i].dateID) {
                    let year = calendar.component(.year, from: date)
                    if currentYear == year {
                        count += 1
                    }
                }
            }
        }
        
    return count
    }
    
    /*
     //KEEEEEEP
    func addRBT<T: RBTObject>(message: String, path: String, savedType: inout [T]){
        let stringDate = getTodaysDate()
        
        //Update existing roses
        for i in 0..<savedType.count {
            if savedType[i].dateID == stringDate {
                savedType[i].message = message
            }
        }
        //Updates the database
        let rootRef = Database.database().reference()
        let ref = rootRef.child("Users/\(self.UserProfile.id_string)")
        let NewPath = "Mindfulness_Section/\(stringDate)/\(path)/Message"
        ref.child(NewPath).setValue(message)
        
        print("Added/Updating a new \(path) [+]")
        fetchRoses()
        
    }
     */
    
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
        //print("Fetching a user bud for user \(self.UserProfile.id_string)")
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
                                if !(self.savedBuds.contains(budObject)) {
                                    self.savedBuds.append(budObject)
                                }
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
        
        print("Added a new Bud [+]")
        fetchBuds()
    }
    
                                                                    /* THORN FUNCTIONS*/
    func fetchThorns() {
        //print("Fetching a user thorn for user \(self.UserProfile.id_string)")
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
                                if !(self.savedThorns.contains(thornObject)) {
                                    self.savedThorns.append(thornObject)
                                }
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
        //print("Fetching open data for user \(self.UserProfile.id_string)")
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
                        if !(self.savedOpens.contains(openObject)) {
                            self.savedOpens.append(openObject)
                        }
                        
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
    
    //func addFavorites(stringDate: String, path: String){
    func addFavoriteRBT<T: RBTObject>(stringDate: String, path: String, savedType: inout [T]){
        var value = ""
        
        if Getfavorite(with: savedType, stringDate: stringDate) == "true" {
            value = "false"
        } else { //"false" or ""
            value = "true"
        }
        
        for i in 0..<savedType.count {
               if savedType[i].dateID == stringDate {
                   savedType[i].favorite = value
               }
           }
        
        let rootRef = Database.database().reference()
        let ref = rootRef.child("Users/\(self.UserProfile.id_string)")
        let NewPath = "Mindfulness_Section/\(stringDate)/\(path)/Favorite"
        ref.child(NewPath).setValue(value)
         
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
    
    /*
    func getRBT(with array: [RBTObject], stringDate: String) -> [String: String]? {
        
        //for calendar it comes in as "M/DD/YY"
        print("Date", stringDate)
        
        //array date looks like "YYYY-MM-DD"
        
        //gets the message and favorite for a specific day
        //depends on which array you pass in - savedRoses - savedBuds - savedThorns
        for i in 0..<array.count {
            print("IN DATE LOOKS LIKE:", array[i].dateID)
            if array[i].dateID == stringDate {
                return ["message": array[i].message, "favorite": array[i].favorite]
            }
        }
        return nil
    }
     */
    
    
    func getRBT(with array: [RBTObject], stringDate: String) -> [String: String]? {
        var newDATE = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/dd/yy"
        if let date = dateFormatter.date(from: stringDate) {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            newDATE = dateFormatter.string(from: date)
        } else {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            if let date = dateFormatter.date(from: stringDate) {
                newDATE = dateFormatter.string(from: date)
            } else {
                return nil
            }
        }
        for i in 0..<array.count {
            if array[i].dateID == newDATE {
                return ["message": array[i].message, "favorite": array[i].favorite]
            }
        }
        return nil
    }
    
    //OPEN
    func getOpen(with array: [TheOpenObject], stringDate: String) -> [String: String]? {
        var newDATE = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/dd/yy"
        if let date = dateFormatter.date(from: stringDate) {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            newDATE = dateFormatter.string(from: date)
        } else {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            if let date = dateFormatter.date(from: stringDate) {
                newDATE = dateFormatter.string(from: date)
            } else {
                return nil
            }
        }
        //gets the message and favorite for a specific day
        //depends on which array you pass in - savedRoses - savedBuds - savedThorns
        for i in 0..<array.count {
            if array[i].dateID == newDATE {
                return ["message": array[i].userInput, "favorite": array[i].favorite]
            }
        }
        return nil
    }
    
    func addFavoriteOpen(stringDate: String){
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
        //print("Fetching a user grat for user \(self.UserProfile.id_string)")
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
                                
                                if !(self.savedGratitudes.contains(gratObject)) {
                                    self.savedGratitudes.append(gratObject)
                                }
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
        
        var newDATE = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/dd/yy"
        if let date = dateFormatter.date(from: stringDate) {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            newDATE = dateFormatter.string(from: date)
        } else {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            if let date = dateFormatter.date(from: stringDate) {
                newDATE = dateFormatter.string(from: date)
            } else {
                return nil
            }
        }
        
        //gets the message and favorite for a specific day
        for i in 0..<array.count {
            if array[i].dateID == newDATE {
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
        
        var value = ""
        
        if getGrat(array: savedGratitudes, stringDate: stringDate, whichInput: whichInput)?["favorite"] == "true" {
            value = "false"
        } else { //"false" or ""
            value = "true"
        }
        
        //Update savedBuds
        for i in 0..<self.savedGratitudes.count {
            if self.savedGratitudes[i].dateID == stringDate {
                
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
    
    
    func isDateInCurrentPeriod(dateString: String, period: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
            let currentDate = Date()
            if period == "week"{
                let currentWeek = calendar.component(.weekOfYear, from: currentDate)
                let givenWeek = calendar.component(.weekOfYear, from: date)
                return currentWeek == givenWeek
            } else{
                let currentMonth = calendar.component(.month, from: currentDate)
                let givenMonth = calendar.component(.month, from: date)
                return currentMonth == givenMonth
            }
        }
        return false
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
    
    static let NEWbackground = Color("NEWbackground")
//=======
    static let darkBackground = Color("darkBackground")
    static let lightButtonColor = Color("lightButtonColor")
    static let activeButtonColor = Color("activeButtonColor")
    static let reminderBackground = Color("reminderBackground")
    static let reminderInsideBackground = Color("reminderInsideBackground")
//>>>>>>> main
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
    @State private var savedNotifications: [UNNotificationRequest] = []

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
    

    func enableNotifications() {
        // Recreate notification requests from saved data entities
        for request in savedNotifications {
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error adding notification: \(error.localizedDescription)")
                }
            }
        }
        
        // Clear saved notifications
        self.savedNotifications.removeAll()
        print("--> Success in enabling notifications")

    }

    func disableNotifications() {
        // Save all pending notifications in the savedNotifications array
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            self.savedNotifications = requests
        }
        
        // Remove all pending notification requests
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        print("--> Success in disabling notifications")
    }
}
