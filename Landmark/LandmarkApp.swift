//
//  LandmarkApp.swift
//  Landmark
//
//  Created by 최범수 on 2025-02-05.
//

import SwiftUI
import Firebase

@main
struct LandmarkApp: App {
    @StateObject private var authViewModel = AuthManager.shared
    init() {
        FirebaseApp.configure()
    }
    @StateObject private var appSettings = AppSettings()
    var body: some Scene {
        WindowGroup {
            if authViewModel.user != nil {
                ContentView()
                    .environmentObject(appSettings)
            } else {
                AuthView()
            }
        }
    }
}


class AppSettings: ObservableObject {
    @Published var tab: Int = 0
    @Published var showingSheet = false
}

