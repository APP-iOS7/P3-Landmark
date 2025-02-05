//
//  AuthViewModel.swift
//  Landmark
//
//  Created by 최범수 on 2025-02-05.
//

import Foundation

@Observable
final class AuthViewModel {
    var email: String = ""
    var password: String = ""
    var showForgetPass = false
    var selectedAuthStyle: AuthStyle = .signUp
    var isSignUp: Bool { return selectedAuthStyle == .signUp }
    var isLoading = false
    var isAuthenticated = false // 로그인 성공여부 추가
    var navigationPath = [String]() // 네비게이션 경로관리
    
    func buttonDidTap() {
        Task {
            do {
                if selectedAuthStyle == .signUp {
                    try await AuthManager.shared.signUp(email: email, password: password)
                    isLoading = false
                } else {
                    try await AuthManager.shared.signIn(email: email, password: password)
                }
                isLoading = false
                navigationPath.append("Main") // 로그인 성공 시 상태 변경
            } catch {
                print("Auth Error:\(error.localizedDescription)")
                isLoading = false
            }
        }
    }
}
