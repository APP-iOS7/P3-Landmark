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
    @EnvironmentObject var appSetting: AppSettings
    
    
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
                        
                    } else {
                        Text("닉네임 안 만들어 주시나요?")
                    }
                    
                    Spacer()
                }
                .padding()

                Button {
                    appSetting.tab = 1
                } label: {
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
                
                Button {
                    appSetting.tab = 0
                } label: {
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
                    .padding(.horizontal)
                }
                .buttonStyle(.plain)
                
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
        }
        
    }

#Preview {
    MypageView()
}
