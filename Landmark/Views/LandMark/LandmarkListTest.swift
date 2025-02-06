//
//  LandmarkListTest.swift
//  Landmark
//
//  Created by 김덕원 on 2/6/25.
//

import SwiftUI

struct LandmarkListTest: View {
    @State private var VM: LandmarkViewModel = .init()
    @EnvironmentObject var tabSetting: AppSettings

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HStack {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(.black)
                                .padding(.leading, 15)
                            
                            TextField("지역, 공간 검색", text: $VM.searchText)
                                .foregroundStyle(.black)
                                .frame(width: 300, height: 50)
                                .onChange(of: VM.searchText) {
                                    Task {
                                        await VM.fetchLandmarks()
                                    }
                                }
                        }
                        .background(Color(.systemGray6))
                        .cornerRadius(20)
                        .padding(.top, 20)
                        
                        if !VM.searchText.isEmpty {
                            Button(action: {
                                VM.searchText = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                    .tint(.black)
                                
                            }
                            .padding(.leading, 5)
                            .padding(.top, 20)
                        }
                        
                    }
                    .padding(.horizontal)
                    List {
                        ForEach(VM.landmarks) { landmark in
                            NavigationLink(value: landmark) {
                                HStack {
                                    if let imageUrl = landmark.firstimage2, let url = URL(string: imageUrl) {
                                        AsyncImage(url: url) { phase in
                                            switch phase {
                                            case .empty:
                                                ProgressView()
                                            case .success(let image):
                                                image.resizable()
                                                    .scaledToFit()
                                                    .frame(width: 50, height: 50)
                                            case .failure:
                                                Image(systemName: "photo")
                                                    .resizable()
                                                    .frame(width: 50, height: 50)
                                            default:
                                                EmptyView()
                                            }
                                        }
                                    } else {
                                        Image(systemName: "photo")
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                    }
                                    Text(landmark.title)
                                        .font(.headline)
                                }
                            }
                        }
                    }
                    .navigationDestination(for: Item.self) { landmark in
                        LandMarkDetailView(landmark: landmark)
                    }
                }
            }
            FloatingTabBar(selectedTab: $tabSetting.tab)
        }
    }
}


#Preview {
    LandmarkListTest()
}
