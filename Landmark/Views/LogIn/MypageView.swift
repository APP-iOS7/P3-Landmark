//
//  MainView.swift
//  Firebasecamp
//
//  Created by 김덕원 on 2/5/25.
//

import SwiftUI

struct MypageView: View {
    @State private var navigationPath = [String]()
    @ObservedObject var authViewModel = AuthManager.shared
    
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                HStack {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width:60, height:60)
                        .padding(.top, 20)
                    
                    if let userEmail = authViewModel.user?.email {
                        Text(userEmail)
                            .padding(.top, 20)
                        
                    }
                    
                    Spacer()
                }
                .padding()

                
                // 메뉴 리스트
                NavigationLink(destination: FavoriteView()) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("관심 여행지")
                                .font(.headline)
                                .foregroundStyle(.black)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.gray)
                    }
                    .padding()
                    .padding(.horizontal)
                }
                .padding(.top, 30)
                .buttonStyle(.plain)
                
                Divider()
                
                NavigationLink(destination: LandmarkMapView()) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("여행지 검색")
                                .font(.headline)
                                .foregroundStyle(.black)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.gray)
                    }
                    .padding()
                }
                .buttonStyle(.plain)
                .padding(.horizontal)
                
                Divider()
                    Button(action: {
                        authViewModel.logout()
                    }) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Log Out")
                                    .font(.headline)
                                    .foregroundStyle(.black)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.gray)
                        }
                        .padding()
                        }
                    .buttonStyle(.plain)
                    .padding(.horizontal)
                }
            Divider()
                Spacer()
            }
            .navigationTitle("MyPage")
            // 네비게이션 이동
            .navigationDestination(for: String.self) { view in
                if view == "Auth" {
                    AuthView()
                }
            }
        }
        
    }

#Preview {
    MypageView()
}
