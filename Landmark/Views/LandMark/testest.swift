//
//  FavoriteView.swift
//  Landmark
//
//  Created by 최범수 on 2025-02-05.
//

import SwiftUI
import SwiftData

struct FavoriteViewTest: View {
    //    @Query private var favoriteItems: [FavoriteItem]
    @EnvironmentObject var appSetting: AppSettings
    var body: some View {
        NavigationStack {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 20) {
                    Image("TripImage") // 이미지
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 320, height: 580)
                        .cornerRadius(20)
                        .overlay(
                            VStack {
                                Text("TripImage")
                                    .padding(.top, 20)
                                    .foregroundStyle(.white)
                                    .font(.title)
                                
                                Text("wiwiwi")
                                    .foregroundStyle(.white)
                                    .font(.headline)
                                
                                Spacer()
                        }
                            
                    )
                    
                           
                    Image("TripImage") // 이미지
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 320, height: 580)
                        .cornerRadius(20)
                    
                    Image("TripImage") // 이미지
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 320, height: 580)
                        .cornerRadius(20)
                }
                .padding(.leading, 30)
                }
            .padding(.top, 10)
            
            .navigationDestination(for: Item.self) { landmark in
                TestDetailView()
            }
            
            FloatingTabBar(selectedTab: $appSetting.tab)
        }
        
    }
}

#Preview {
    FavoriteView()
        .environmentObject(AppSettings())
}
