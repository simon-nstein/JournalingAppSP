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
        let usersRef = databaseRef.child("Users")
        let singleUserRef = usersRef.child(username)
        let data = ["Mindfulness_Section": "",
                    "Gratitude_Section": "",
                    "Open_Section": "",
                    "Notification": "false",
                    "Notification_Time": "",
                    "Goal": ""
        ]
        singleUserRef.setValue(data)
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
}

struct CustomFontSize {
    static let tinyFontSize: CGFloat = 8;
    static let smallFontSize: CGFloat = 12;
    static let standardFontSize: CGFloat = 15;
    static let inputFontSize: CGFloat = 22;
    static let largeFontSize: CGFloat = 30;
    static let extraLargeFont: CGFloat = 40;
}

class JournalData: ObservableObject {
    @Published var model = JournalModel()
    @Published var savedRoses: [RoseEntity] = []
    @Published var savedBuds: [BudEntity] = []
    @Published var savedThorns: [ThornEntity] = []

    
    // Initialize Core Data
    let CoreDataContainer: NSPersistentContainer
    
    init () {
        CoreDataContainer = NSPersistentContainer(name: "JournalCoreData")
        CoreDataContainer.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading data [-]. \(error)")
            } else {
                print("Successfully loaded core data. [+]")
            }
        }
        fetchRoses()
        fetchBuds()
        fetchThorns()
    }

    
    // Functions
    
    // A function that deletes all the entries in your CoreData for each entity
    func deleteAllEntries() {
        let request = NSFetchRequest<RoseEntity>(entityName:"RoseEntity")
        let request2 = NSFetchRequest<BudEntity>(entityName:"BudEntity")
        let request3 = NSFetchRequest<ThornEntity>(entityName:"ThornEntity")
        
        do {
            
            savedRoses = try CoreDataContainer.viewContext.fetch(request)
            for item in savedRoses {
                CoreDataContainer.viewContext.delete(item)
            }
            
            savedBuds = try CoreDataContainer.viewContext.fetch(request2)
            for item in savedBuds {
                CoreDataContainer.viewContext.delete(item)
            }
            
            savedThorns = try CoreDataContainer.viewContext.fetch(request3)
            for item in savedThorns {
                CoreDataContainer.viewContext.delete(item)
            }
             
            saveData()
            print("all entries successfully deleted")
        } catch {
            print("Error deleting roses [-]. \(error)")
        }
    }
    
    // Saves all updated data and recalls the roses, buds, and thorns
    func saveData() {
        do {
            try CoreDataContainer.viewContext.save()
            fetchRoses()
            fetchBuds()
            fetchThorns()
        } catch let error {
            print("Error saving [-]. \(error)")
        }
    }
    
    // ROSE FUNCTIONS
    func fetchRoses() {
        let request = NSFetchRequest<RoseEntity>(entityName: "RoseEntity")
        
        do {
            savedRoses = try CoreDataContainer.viewContext.fetch(request)
        } catch {
            print("Error fetching roses [-]. \(error)")
        }
    }
    
    func addRose(with message: String) {
        let todayDate = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let stringDate = formatter.string(from: todayDate)
        for i in 0..<self.savedRoses.count {
            if self.savedRoses[i].dateID == stringDate {
                self.savedRoses[i].roseMessage = message
                return
            }
        }
        let roseObject = RoseEntity(context: CoreDataContainer.viewContext)
        roseObject.roseMessage = message
        roseObject.dateID = stringDate
        roseObject.dateEntered = todayDate
    }
    
    func getTodaysRose() -> String? {
        let todayDate = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let stringDate = formatter.string(from: todayDate)
        
        for i in 0..<self.savedRoses.count {
            if self.savedRoses[i].dateID == stringDate {
                return self.savedRoses[i].roseMessage
            }
        }
        return nil
    }
    
    
    // BUD FUNCTIONS
    func fetchBuds() {
        let request = NSFetchRequest<BudEntity>(entityName: "BudEntity")
        
        do {
            savedBuds = try CoreDataContainer.viewContext.fetch(request)
        } catch {
            print("Error fetching buds [-]. \(error)")
        }
    }
    
    func addBud(with message: String) {
        let todayDate = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let stringDate = formatter.string(from: todayDate)
        for i in 0..<self.savedBuds.count {
            if self.savedBuds[i].dateID == stringDate {
                self.savedBuds[i].budMessage = message
                return
            }
        }
        let budObject = BudEntity(context: CoreDataContainer.viewContext)
        budObject.budMessage = message
        budObject.dateID = stringDate
        budObject.dateEntered = todayDate
    }
    
    func getTodaysBud() -> String? {
        let todayDate = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let stringDate = formatter.string(from: todayDate)
        
        for i in 0..<self.savedBuds.count {
            if self.savedBuds[i].dateID == stringDate {
                return self.savedBuds[i].budMessage
            }
        }
        return nil
    }
    

    // THORN FUNCTIONS
    func fetchThorns() {
        let request = NSFetchRequest<ThornEntity>(entityName: "ThornEntity")
        
        do {
            savedThorns = try CoreDataContainer.viewContext.fetch(request)
        } catch {
            print("Error fetching thorns [-]. \(error)")
        }
    }
    
    func addThorn(with message: String) {
        let todayDate = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let stringDate = formatter.string(from: todayDate)
        for i in 0..<self.savedThorns.count {
            if self.savedThorns[i].dateID == stringDate {
                self.savedThorns[i].thornMessage = message
                return
            }
        }
        let thornObject = ThornEntity(context: CoreDataContainer.viewContext)
        thornObject.thornMessage = message
        thornObject.dateID = stringDate
        thornObject.dateEntered = todayDate
    }
    
    func getTodaysThorn() -> String? {
        let todayDate = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let stringDate = formatter.string(from: todayDate)
        
        for i in 0..<self.savedThorns.count {
            if self.savedThorns[i].dateID == stringDate {
                return self.savedThorns[i].thornMessage
            }
        }
        return nil
    }
    
    
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
