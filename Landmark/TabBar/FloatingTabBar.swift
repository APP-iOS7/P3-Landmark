//
//  FloatingTabBar.swift
//  Landmark
//
//  Created by 김덕원 on 2/6/25.
//

import SwiftUI

struct FloatingTabBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack {
            Spacer()
            TabButton(icon: "magnifyingglass", label:"검색",index: 0, selectedTab: $selectedTab)
            Spacer()
            TabButton(icon: "heart.fill",label:"좋아요", index: 1, selectedTab: $selectedTab)
            Spacer()
            TabButton(icon: "person.fill",label:"내 정보", index: 2, selectedTab: $selectedTab)
            Spacer()
        }
        .frame(height: 70)
        .background(Color.white)
        .cornerRadius(35)
        .shadow(radius: 10)
        .padding(.horizontal, 20)
    }
}

