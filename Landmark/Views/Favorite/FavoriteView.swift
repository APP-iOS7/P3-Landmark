//
//  FavoriteView.swift
//  Landmark
//
//  Created by 최범수 on 2025-02-05.
//

import SwiftUI
import SwiftData

struct FavoriteView: View {
    @Query private var favoriteItems: [FavoriteItem]
    @EnvironmentObject var appSetting: AppSettings
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    List {
                        ForEach(favoriteItems) { item in
                            NavigationLink(value: item) {
                                HStack {
                                    AsyncImage(url: URL(string: item.imgURL)) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                        case .success(let image):
                                            image.resizable()
                                                .scaledToFit()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 120, height: 80)
                                                .cornerRadius(8)
                                        case .failure:
                                            Image("MyCat")
                                                .resizable()
                                                .frame(width: 120, height: 80)
                                                .cornerRadius(8)
                                        default:
                                            EmptyView()
                                        }
                                    }
                                    
                                    VStack(alignment: .leading) {
                                        Text(item.title) // 이름
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
                                    Text(item.address) // 주소
                                        .font(.subheadline)
                                        .padding(.leading, 10)
                                        .foregroundStyle(.gray)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            }

                        }
                    }
                    .navigationDestination(for: FavoriteItem.self) { favoriteItem in
                        FavoriteDetailView(favoriteItem: favoriteItem)
                    }
                }
                
            }
        }
        .padding(.top, 10)
        .listStyle(.inset)
        
        
        FloatingTabBar(selectedTab: $appSetting.tab)
    }
    
}

#Preview {
    FavoriteView()
        .environmentObject(AppSettings())
}
