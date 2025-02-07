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
                .padding(.leading)
                
                Spacer()
                
                Button {
                    authViewModel.logout()
                } label: {
                    Text("Log out")
                }
                .padding()
                .background(Color.red)
                .foregroundStyle(.white)
                .cornerRadius(10)
                .padding()
                
                Spacer()
            }
            .navigationDestination(for: String.self) { view in
                if view == "Auth" {
                    AuthView()
                }
            }
        }
        
    }
}

#Preview {
    MypageView()
}
