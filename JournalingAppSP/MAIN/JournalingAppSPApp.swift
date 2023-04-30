//
//  JournalingAppSPApp.swift
//  JournalingAppSP
//
//  Created by Simon Neuwirth-Stein on 3/2/23.
//

import SwiftUI

@main
struct JournalingAppSPApp: App {
    let sharedData = SharedData()
    var body: some Scene {
        WindowGroup {
            LoginSystemView()
                .environmentObject(sharedData)
        }
    }
}
