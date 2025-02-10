//
//  LandmarkApp.swift
//  Landmark
//
//  Created by 최범수 on 2025-02-05.
//

import SwiftUI
import Firebase
import KakaoSDKAuth
import KakaoSDKCommon
import MapKit
import SwiftData


@main
struct LandmarkApp: App {
    @StateObject private var authViewModel = AuthManager.shared
    @StateObject private var appSettings = AppSettings()
    
    init() {
        FirebaseApp.configure()
        KakaoSDK.initSDK(appKey: "{6a0d0977198785e56f0d508a0dc93ff5}")
    }

    var body: some Scene {
        WindowGroup {
            if authViewModel.user != nil {
                ContentView() .onOpenURL { url in
                    if (AuthApi.isKakaoTalkLoginUrl(url)) {
                       _ = AuthController.handleOpenUrl(url: url)
                    }
                }
                    .environmentObject(appSettings)
                    .modelContainer(for: FavoriteItem.self)
            } else {
                AuthView()
            }
               
        }
    }
}

class AppSettings: ObservableObject {
    @Published var tab: Int = 0
    @Published var showingSheet = false
    @Published var coordinate = CLLocationCoordinate2D(latitude: 37.555946
                                               , longitude: 126.972317)
}
