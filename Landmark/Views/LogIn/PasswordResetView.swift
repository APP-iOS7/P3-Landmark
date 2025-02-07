//
//  PasswordResetView.swift
//  Firebasecamp
//
//  Created by 김덕원 on 2/5/25.
//

import SwiftUI

struct PasswordResetView: View {
    @Binding var showForgetPass: Bool
    @State var passwordMail: String = ""
    @ObservedObject private var authViewModel = AuthManager.shared
    
    var body: some View {
        VStack {
            Text("비밀번호 재설정")
                .font(.system(.title3, design: .rounded, weight: .bold))
                .foregroundColor(.white.opacity(0.85))
                .multilineTextAlignment(.center)
            
            TextField("Email",
                      text:$passwordMail,
                        prompt:
                         Text("Email").foregroundStyle(.white)
                      )
            .textFieldStyle(IconTextFieldStyle(iconName: "envelope.fill"))
            .textInputAutocapitalization(.never)
            .keyboardType(.emailAddress)
            
            Button {
                Task {
                    do {
                        try await authViewModel.resetPassword(email: passwordMail)
                    } catch {
                        print("Password Reset error: \(error.localizedDescription)")
                    }
                }
                showForgetPass = false
            } label: {
                Text("메일 보내기")
                    .font(.system(.title3, design: .rounded))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(Color.blue)
            .foregroundStyle(.white)
            .cornerRadius(10)
        }
    }
}

