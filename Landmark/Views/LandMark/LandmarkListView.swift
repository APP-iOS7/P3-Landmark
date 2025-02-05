//
//  LandmarkListView.swift
//  Landmark
//
//  Created by 최범수 on 2025-02-05.
//

import SwiftUI

struct LandmarkListView: View {
    @State private var VM: LandmarkListViewModel = .init()
    var body: some View {
        NavigationStack {
            HStack {
                TextField("검색어를 입력하세요", text: $VM.searchText)
                Button("검색") {
                    Task {
                        await VM.fetchLandmarks()
                    }
                }
            }
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
            .navigationTitle("Landmark List")
            .navigationDestination(for: Item.self) { landmark in
                LandMarkDetailView(landmark: landmark)
            }
        }
    }
}

#Preview {
    LandmarkListView()
}
