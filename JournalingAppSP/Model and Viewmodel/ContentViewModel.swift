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
            let today = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter.string(from: today)
        }
        let mindfulnessRef = databaseRef.child("Users/\(username)/Mindfulness_Section/\(DATE)")
        let gratitudeRef = databaseRef.child("Users/\(username)/Gratitude_Section/\(DATE)")
        let openRef = databaseRef.child("Users/\(username)/Open_Section/\(DATE)")

        mindfulnessRef.child("Rose").setValue(["Message":"", "Favorite": ""])   // Adds new sections for Rose, Bud, Thorn, Gratitude, Open Journal, and Notifications
        mindfulnessRef.child("Bud").setValue(["Message":"", "Favorite": ""])
        mindfulnessRef.child("Thorn").setValue(["Message":"", "Favorite": ""])
        gratitudeRef.setValue(["userInput":"", "favorite":""])
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
}

struct CustomFontSize {
    static let tinyFontSize: CGFloat = 8;
    static let smallFontSize: CGFloat = 12;
    static let standardFontSize: CGFloat = 15;
    static let inputFontSize: CGFloat = 22;
    static let largeFontSize: CGFloat = 30;
    static let extraLargeFont: CGFloat = 40;
}



/* JournalData ViewModel */
class JournalData: ObservableObject {
    @Published var model = JournalModel()
    @Published var savedRoses: [RoseEntity] = []
    @Published var savedBuds: [BudEntity] = []
    @Published var savedThorns: [ThornEntity] = []
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    let UserProfile: Profile

    
    // Initialize Core Data
    //let CoreDataContainer: NSPersistentContainer
    
    init (UserProfile: Profile) {
        /*
        CoreDataContainer = NSPersistentContainer(name: "JournalCoreData")
        CoreDataContainer.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading data [-]. \(error)")
            } else {
                print("Successfully loaded core data. [+]")
            }
        }
         */
        self.UserProfile = UserProfile
        fetchRoses()
        //fetchBuds()
        //fetchThorns()
    }


    
// ROSE FUNCTIONS
    
    func fetchRoses() {
        // Get all the roses entered by a certain user
        print("Fetching a user rose for user \(self.UserProfile.id_string)")
        
    }
    
    // Adds a new rose to the database
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
        // Update Firebase with new information below
    }
    
    // Returns the rose that was typed today else nil if not exists
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
