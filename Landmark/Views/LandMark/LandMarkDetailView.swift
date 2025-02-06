//
//  LandMarkDetailView.swift
//  Landmark
//
//  Created by 최범수 on 2025-02-05.
//

import SwiftUI


struct LandMarkDetailView: View {
    @State var VM = LandmarkViewModel()
    @EnvironmentObject var appSetting: AppSettings
    
    let landmark: Item
    
    var body: some View {
        ScrollView {
            AsyncImage(url: URL(string: VM.detailLandmark.firstimage ?? ""), scale: 1) { image in
                image
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 0.5)
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 0.6)
            }
            
            
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
                    .frame(maxWidth: .infinity, alignment: .leading)
                Button {
                    // 좋아요 누르면 리스트에 추가됨
                } label: {
                    Text("좋아요")
                }
                .padding()
            }
            .padding()
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
}

#Preview {
    //    LandMarkDetailView(landmark: MockItem.shared)
}
