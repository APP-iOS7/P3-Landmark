//
//  LandMarkDetailView.swift
//  Landmark
//
//  Created by 최범수 on 2025-02-05.
//

import SwiftUI
import SwiftData

struct LandMarkDetailView: View {
    @State private var VM = LandmarkViewModel()
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var appSetting: AppSettings
    
    let landmark: Item
    
    var body: some View {
        ScrollView {
            AsyncImage(url: URL(string: VM.detailLandmark.firstimage ?? ""), scale: 1) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill) // Avoid image cropping
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.55)
                    .cornerRadius(10) // Match corner radius
                    .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4) // Shadow for better depth
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 0.6)
                    .cornerRadius(10) // Rounded corners for consistency
            }
            
            VStack(alignment: .leading, spacing: 15) {
                Text(VM.detailLandmark.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding([.top, .horizontal])
                
                HStack {
                    Text(VM.detailLandmark.tel ?? "전화번호 없음")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding([.horizontal])
                
                Divider()
                
                // Address Section
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundStyle(.black)
                        Text("주소")
                            .font(.headline)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    
                    Text(VM.detailLandmark.addr1)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .lineLimit(3) // Limit lines to avoid overflow
                    
                    Divider()
                }
                .padding([.horizontal, .top])
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                
                // About Section
                VStack(alignment: .leading, spacing: 10) {
                    Text("About")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text(VM.detailLandmark.overview ?? "상세 정보 없음")
                        .font(.body)
                        .foregroundColor(.gray)
                        .fixedSize(horizontal: false, vertical: true) // Prevent text clipping
                }
                .padding([.horizontal])
                
                // Like Button
                Button {
                    addToFavorite()
                } label: {
                    Text("좋아요")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(color: Color.blue.opacity(0.3), radius: 6, x: 0, y: 4)
                }
                .padding([.horizontal, .bottom])
            }
            .padding([.horizontal])
        }
        .onAppear {
            Task {
                await VM.fetchDetailLandmark(id: landmark.contentid)
                appSetting.coordinate = VM.detailLandmark.locationCoordinate
            }
        }
        .navigationTitle(landmark.title)
        .navigationBarTitleDisplayMode(.automatic)
    }
    
    func addToFavorite() {
        let savemodel = FavoriteItem(contentid: landmark.contentid, title: landmark.title, latitude: landmark.mapy, longitude: landmark.mapx, imgURL: landmark.firstimage!, address: landmark.addr1)
        print(landmark.contentid)
        print(savemodel)
        dump(savemodel)
        modelContext.insert(savemodel)
    }
}
