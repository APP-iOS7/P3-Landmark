//
//  LandmarkListTest.swift
//  Landmark
//
//  Created by 김덕원 on 2/6/25.
//

import SwiftUI

struct LandmarkListTest: View {
    @State private var VM: LandmarkListViewModel = .init()
    
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
                        .padding(.top, 40)
                        
                        if !VM.searchText.isEmpty {
                            Button(action: {
                                VM.searchText = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                //                                .foregroundStyle(.gray.opacity(0.4))
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
                                                Image(systemName: "photo") // 기본 이미지 제공
                                                    .resizable()
                                                    .frame(width: 50, height: 50)
                                            default:
                                                EmptyView()
                                            }
                                        }
                                    } else {
                                        Image(systemName: "photo") // 기본 이미지 제공
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
                FloatingTabBar()
            }
            
        }
    }
}
struct FloatingTabBar: View {
    @State private var selectedTab: Int = 0
    @State private var isShowingDetail = false
    
    var body: some View {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    
                    // 각 탭 아이콘
                    Button(action: {
                        selectedTab = 0
                    }) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 25))
                            .foregroundColor(selectedTab == 0 ? .blue : .gray)
                    }
                    Spacer()
                    
                    Button(action: {
                        selectedTab = 1
                    }) {
                        Image(systemName: "heart.fill")
                            .font(.system(size: 25))
                            .foregroundColor(selectedTab == 1 ? .blue : .gray)
                    }
                    Spacer()
                    
                    Button(action: {
                        selectedTab = 2
                    }) {
                        Image(systemName: "person.fill")
                            .font(.system(size: 25))
                            .foregroundColor(selectedTab == 2 ? .blue : .gray)
                        }
                    
                    Spacer()
                }
                .frame(height: 70)
                .background(Color.white)
                .cornerRadius(35)
                .shadow(radius: 10)
                .padding()
            }
            .edgesIgnoringSafeArea(.all)
        }
    }

#Preview {
    LandmarkListTest()
}
