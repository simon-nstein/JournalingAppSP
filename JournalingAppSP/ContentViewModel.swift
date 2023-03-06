//
//  ContentViewModel.swift
//  JournalingAppSP
//
//  Created by Paul McSlarrow on 3/3/23.
//

import Foundation
import SwiftUI
import CoreData


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
    static let RoseFontSize: CGFloat = 22;
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
        //deleteAllEntries(from: "RoseEntity")
        fetchRoses()
    }

    
    // Functions
    func deleteAllEntries(from entity: String) {
        let request = NSFetchRequest<RoseEntity>(entityName:entity)
        
        do {
            savedRoses = try CoreDataContainer.viewContext.fetch(request)
            for item in savedRoses {
                CoreDataContainer.viewContext.delete(item)
            }
            saveData()
        } catch {
            print("Error deleting roses [-]. \(error)")
        }
    }
    
    // Updates the array "savedRoses" with all entries that exist in the database
    func fetchRoses() {
        let request = NSFetchRequest<RoseEntity>(entityName: "RoseEntity")
        
        do {
            savedRoses = try CoreDataContainer.viewContext.fetch(request)
        } catch {
            print("Error fetching roses [-]. \(error)")
        }
    }
    
    // Will add (or edit an existing) rose entry in the database
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
    
    func saveData() {
        do {
            try CoreDataContainer.viewContext.save()
            fetchRoses()
        } catch let error {
            print("Error saving [-]. \(error)")
        }
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
    

    // Intents (functions for interaction between UI and backend)
}
