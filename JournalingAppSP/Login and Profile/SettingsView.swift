//
//  SettingsView.swift
//  JournalingAppSP
//
//  Created by Paul McSlarrow on 5/6/23.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: JournalData;
    let userProfile: Profile
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Settings")) {
                    NavigationLink(destination: ReminderView(viewModel: self.viewModel, userProfile: self.userProfile, settingsPageNavigation: true)) {
                        Label("Notifications", systemImage: "bell")
                    }
                }
            }
            .navigationBarTitle("Settings")
        }
    }
}

