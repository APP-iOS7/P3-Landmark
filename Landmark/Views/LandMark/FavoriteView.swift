//
//  FavoriteView.swift
//  Landmark
//
//  Created by 최범수 on 2025-02-05.
//

import SwiftUI
import SwiftData

struct FavoriteView: View {
    //    @Query private var favoriteItems: [FavoriteItem]
    @EnvironmentObject var appSetting: AppSettings
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    List {
                            HStack {
                                Image("TripImage") // 이미지
                                    .resizable()
                                    .scaledToFit()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 120, height: 80)
                                    .cornerRadius(8)
                                
                                
                                VStack(alignment: .leading) {
                                    Text("TripImage") // 이름
                                        .font(.headline)
                                        .padding(.leading, 10)
                                        .foregroundStyle(.black)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    VStack (alignment: .leading) {
                                        Image(systemName: "star.fill") // 아이콘
                                            .padding(.leading, 150)
                                            .padding(.bottom, 30)
                                    }
                                }
                                .padding(5)
                                .background(Color.white)
                                .cornerRadius(12)
                            }
                            VStack {
                                Text("서울시 종로구 12345") // 주소
                                    .font(.subheadline)
                                    .padding(.leading, 10)
                                    .foregroundStyle(.gray)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        
                        
                    }
                    
                }
            }
            .padding(.top, 10)
            .listStyle(.inset)
            
            .navigationDestination(for: Item.self) { landmark in
                TestDetailView()
            }
            
            FloatingTabBar(selectedTab: $appSetting.tab)
        }
        
    }

#Preview {
    FavoriteView()
        .environmentObject(AppSettings())
}
