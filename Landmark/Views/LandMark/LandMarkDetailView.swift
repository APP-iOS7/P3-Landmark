//
//  LandMarkDetailView.swift
//  Landmark
//
//  Created by 최범수 on 2025-02-05.
//

import SwiftUI


struct LandMarkDetailView: View {
    var landmark: Item
    
    var body: some View {
        ScrollView {
            MapView(coordinate: landmark.locationCoordinate)
                .frame(height: 300)
            
            AsyncImage(url: URL(string: landmark.firstimage2!), scale: 1)
                .frame(width: 200, height: 200)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
                .offset(y: -100)
                .padding(.bottom, -100)

            VStack(alignment: .leading) {
                HStack {
                    Text(landmark.title)
                        .font(.title)
                }

                HStack {
                    Text(landmark.tel ?? "번호 없음")
                    Spacer()
                    Text(landmark.addr1)
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)

                Divider()

                Text("About")
                    .font(.title2)
                Text(landmark.title)
                    .frame(maxWidth: .infinity, alignment: .leading)  // 추가
            }
            .padding()
        }
        .navigationTitle(landmark.title)
        .navigationBarTitleDisplayMode(.automatic)
    }
}

#Preview {
//    LandMarkDetailView(landmark: MockItem.shared)
}
