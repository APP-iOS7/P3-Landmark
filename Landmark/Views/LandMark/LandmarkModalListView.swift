//
//  LandmarkModalListView.swift
//  Landmark
//
//  Created by 김덕원 on 2/6/25.
//

import SwiftUI

struct LandmarkModalListView: View {
    @State private var VM: LandmarkViewModel = .init()
    @EnvironmentObject var appSetting: AppSettings

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
                                .padding(.vertical, 12)
                                .padding(.leading, 10)
                                .frame(width: 300, height: 50)
                                .onChange(of: VM.searchText) {
                                    Task {
                                        await VM.fetchLandmarks()
                                    }
                                }
                            if !VM.searchText.isEmpty {
                                Button(action: {
                                    VM.searchText = ""
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                    
                                }
                                .padding(.trailing, 10)
                                .tint(.black)
                                
                            }

                        }
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .shadow(radius: 5)
                        .padding(.top, 20)
                        
                        
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
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 120, height: 80)
                                                    .cornerRadius(8)
                                            case .failure:
                                                Image(systemName: "photo")
                                                    .resizable()
                                                    .frame(width: 120, height: 80)
                                                    .cornerRadius(8)
                                            default:
                                                EmptyView()
                                            }
                                        }
                                    } else {
                                        Image(systemName: "photo")
                                            .resizable()
                                            .frame(width: 120, height: 80)
                                            .cornerRadius(8)
                                    }
                                    Text(landmark.title)
                                        .font(.headline)
                                        .padding(.leading, 10)
                                        .foregroundStyle(.black)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .padding(5)
                                .background(Color.white)
                                .cornerRadius(12)
                            }
                            Text(landmark.addr1)
                                .font(.subheadline)
                                .padding(.leading, 10)
                                .foregroundStyle(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(.top, 10)
                    .listStyle(.inset)
                    
                    .navigationDestination(for: Item.self) { landmark in
                        LandMarkDetailView(landmark: landmark)
                    }
                }
            }
            FloatingTabBar(selectedTab: $appSetting.tab)
        }
    }
}


#Preview {
    LandmarkModalListView()
        .environmentObject(AppSettings())
}
