//
//  ContentView.swift
//  Landmark
//
//  Created by 최범수 on 2025-02-05.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            
            Tab {
                LandmarkListView()
            } label: {
                Label("search", systemImage: "magnifyingglass")
            }
            
            Tab {
                LandmarkListView()
            } label: {
                Label("Favorite", systemImage: "heart")
            }
            Tab {
                MypageView()
            } label: {
                Label("My page", systemImage: "person.fill")
            }
        }
    }
}

#Preview {
    ContentView()
}
