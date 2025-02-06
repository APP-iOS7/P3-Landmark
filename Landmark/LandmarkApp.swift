//
//  LandmarkApp.swift
//  Landmark
//
//  Created by 최범수 on 2025-02-05.
//

import SwiftUI
import Firebase
import MapKit
import SwiftData

@main
struct LandmarkApp: App {
    @StateObject private var authViewModel = AuthManager.shared
    @StateObject private var appSettings = AppSettings()
    
    init() {
        FirebaseApp.configure()
    }
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            FavoriteStore.self, FavoriteItem.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            if authViewModel.user != nil {
                ContentView()
                    .environmentObject(appSettings)
            } else {
                AuthView()
            }
        }
//        .modelContainer(sharedModelContainer)
    }
}

class AppSettings: ObservableObject {
    @Published var tab: Int = 0
    @Published var showingSheet = false
    @Published var coordinate = CLLocationCoordinate2D(latitude: 37.555946
                                               , longitude: 126.972317)
}
