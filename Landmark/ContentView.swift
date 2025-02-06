//
//  ContentView.swift
//  Landmark
//
//  Created by 최범수 on 2025-02-05.
//

import SwiftUI


struct ContentView: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            LandmarkListView()
                .tabItem {
                    Label("search", systemImage: "magnifyingglass")
                }
                .tag(0)
            
            LandmarkListView()
                .tabItem {
                    Label("search", systemImage: "magnifyingglass")
                }
                .tag(1)
            
            MypageView()
                .tabItem {
                    Label("search", systemImage: "magnifyingglass")
                }
                .tag(2)
            
        }
    }
}
#Preview {
    ContentView()
}
