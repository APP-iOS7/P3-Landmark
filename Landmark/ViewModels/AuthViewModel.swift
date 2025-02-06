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
    var toastMessage = ""
    var isShowingToast = false
    
    func buttonDidTap() {
        Task {
            do {
                if selectedAuthStyle == .signUp {
                    try await AuthManager.shared.signUp(email: email, password: password)
                    isLoading = false
                } else {
                    try await AuthManager.shared.signIn(email: email, password: password)
                    isAuthenticated = true
                    showToast(message: "로그인 성공")
                }
                isLoading = false
                navigationPath.append("Main")
            } catch {
                showToast(message: "로그인 실패: \(error.localizedDescription)")
            }
        }
    }
    
    private func showToast(message: String) {
        toastMessage = message
        isShowingToast = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isShowingToast = false
        }
    }
}
