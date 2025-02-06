//
//  TabButton.swift
//  Landmark
//
//  Created by 김덕원 on 2/6/25.
//

import SwiftUI

struct TabButton: View {
    let icon: String
    let label: String
    let index: Int
    @Binding var selectedTab: Int
    @EnvironmentObject var appSetting: AppSettings
    
    var body: some View {
        Button(action: {
            selectedTab = index
            if selectedTab == 0 {
                appSetting.showingSheet = true
            } else {
                appSetting.showingSheet = false
            }
        }) {
            VStack (spacing:8) {
                Image(systemName: icon)
                    .font(.system(size: 25))
                    .foregroundColor(selectedTab == index ? .blue : .gray)
                
                // label
                Text(label)
                    .font(.caption)
                    .foregroundStyle(selectedTab == index ? .blue : .gray)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
      
}
