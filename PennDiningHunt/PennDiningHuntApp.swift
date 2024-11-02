//
//  PennDiningHuntApp.swift
//  PennDiningHunt
//
//  Created by Kevin D on 10/28/24.
//

import SwiftUI

@main
struct PennDiningHuntApp: App {
    @StateObject private var viewModel = DiningHallViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
