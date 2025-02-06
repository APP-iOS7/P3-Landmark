//
//  FavoriteView.swift
//  Landmark
//
//  Created by 갓범수 on 2025-02-05.
//

import SwiftUI
import SwiftData

struct FavoriteView: View {
    @State private var VM: LandmarkViewModel = .init()
    @Query private var favoriteItems: [FavoriteItem]
    @EnvironmentObject var appSetting: AppSettings
    
    var body: some View {
        NavigationStack {
            ScrollView(.horizontal, showsIndicators: false) { // 가로 스크롤
                LazyHStack(spacing: 20) { // 가로 배치
                    ForEach(favoriteItems) { item in
                        NavigationLink(value: item) {
                            VStack {
                                GeometryReader { geo in
                                    let scale = getScale(proxy: geo)
                                    let opacity = getOpacity(proxy: geo)
                                    AsyncImage(url: URL(string: item.imgURL)) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                        case .success(let image):
                                            image.resizable()
                                                .scaledToFill()
                                                .frame(width: 320, height: 450)
                                                .cornerRadius(20)
                                                .overlay(
                                                    ZStack {
                                                        RoundedRectangle(cornerRadius: 20)
                                                            .fill(Color.black.opacity(opacity))
                                                            .frame(width: 320, height: 450)
                                                        
                                                        VStack(alignment: .leading) {
                                                            VStack(alignment: .trailing) {
                                                                Button {
                                                                    item.isDone.toggle()
                                                                } label: {
                                                                    Image(systemName: item.isDone ? "pin.circle.fill" : "pin.circle.fill")
                                                                        .padding(.top, 20)
                                                                        .font(.system(size: 35))
                                                                        .foregroundStyle(item.isDone ? .green : .red)
                                                                        .background(Color.white)
                                                                        .clipShape(.rect(cornerRadii: RectangleCornerRadii(bottomLeading: 10, bottomTrailing:10)))
                                                                }
                                                                Spacer()
                                                                
                                                                Text(item.title)
                                                                    .padding(.bottom, 10)
                                                                    .foregroundStyle(.white)
                                                                    .font(.system(size: 25, weight: .bold))
                                                                
                                                                Text(item.address)
                                                                    .padding(.bottom, 30)
                                                                    .foregroundStyle(.white)
                                                                    .font(.system(size: 15, weight: .bold))
                                                            }
                                                        }
                                                    }
                                                )
                                                .shadow(radius: scale == 1.0 ? 10 : 0)
                                        case .failure:
                                            Image("MyCat")
                                                .resizable()
                                                .frame(width: 320, height: 450)
                                                .cornerRadius(20)
                                                .overlay(
                                                    VStack(alignment: .leading) {
                                                        Text(item.title)
                                                            .padding(.top, 20)
                                                            .foregroundStyle(.black)
                                                            .font(.title)
                                                        
                                                        Text(item.address)
                                                            .foregroundStyle(.white)
                                                            .font(.headline)
                                                        
                                                        Spacer()
                                                    }
                                                )
                                            //
                                        default:
                                            EmptyView()
                                        }
                                        
                                    }
                                    .scaleEffect(scale)
                                    .animation(.spring(response: 0.5, dampingFraction: 0.7), value: scale)
                                }
                                .frame(width: 320, height: 430)
                            }
                        }
                    }
                }
                .padding(.horizontal, (UIScreen.main.bounds.width - 320) / 2) // 좌우 여백 추가
            }
            .navigationDestination(for: FavoriteItem.self) { favoriteItem in
                FavoriteDetailView(favoriteItem: favoriteItem)
            }
            .navigationTitle("관심 여행지")
        }
    }
        
        /// 화면 중앙에 가까울수록 1.0, 멀어질수록 0.8 정도의 scale 값을 반환
        private func getScale(proxy: GeometryProxy) -> CGFloat {
            // 현재 이미지 뷰의 중앙 X좌표 (전역 좌표 기준)
            let midX = proxy.frame(in: .global).midX
            // 화면 중앙 X좌표
            let screenMidX = UIScreen.main.bounds.width / 2
            
            // 중앙과의 거리 차이 (절대값)
            let distance = abs(screenMidX - midX)
            
            // 거리에 따른 scale 조정 (원하는 최소 scale 값 설정, 여기서는 0.8)
            let scale = max(1 - (distance / 400), 0.85)
            return scale
        }
    
    /// 중앙에 있을수록 투명, 멀어질수록 검정 오버레이 (최대 0.3)
        private func getOpacity(proxy: GeometryProxy) -> CGFloat {
            let midX = proxy.frame(in: .global).midX
            let screenMidX = UIScreen.main.bounds.width / 2
            let distance = abs(screenMidX - midX)
            
            let opacity = max(distance / 400, 0.5) // 최대 0.5까지 어두워짐
            return opacity
        }
    }
