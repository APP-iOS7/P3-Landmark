//
//  LandMarkDetailView.swift
//  Landmark
//
//  Created by 최범수 on 2025-02-05.
//

import SwiftUI


struct LandMarkDetailView: View {
    @State var VM = LandmarkViewModel()
    
    let landmark: Item
    
    var body: some View {
        ScrollView {
            MapView(coordinate: VM.detailLandmark.locationCoordinate)
                .frame(height: 300)
            
            AsyncImage(url: URL(string: VM.detailLandmark.firstimage2!), scale: 1)
                .frame(width: 200, height: 200)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
                .offset(y: -100)
                .padding(.bottom, -100)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(VM.detailLandmark.title)
                        .font(.title)
                }
                
                HStack {
                    Text(VM.detailLandmark.tel ?? "번호 없음")
                    Spacer()
                    Text(VM.detailLandmark.addr1)
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
                
                Divider()
                
                Text("About")
                    .font(.title2)
                Text(VM.detailLandmark.overview ?? "")
                    .frame(maxWidth: .infinity, alignment: .leading)  // 추가
            }
            .padding()
        }
        .onAppear {
            Task {
                await VM.fetchDetailLandmark(id: landmark.contentid)
                
            }
        }
        .navigationTitle(landmark.title)
        .navigationBarTitleDisplayMode(.automatic)
    }
}

#Preview {
    //    LandMarkDetailView(landmark: MockItem.shared)
}
