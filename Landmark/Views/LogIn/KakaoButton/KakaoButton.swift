//
//  KakaoButton.swift
//  Landmark
//
//  Created by 김덕원 on 2/10/25.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser


struct KakaoButton: View {
    var body: some View {
        VStack {
            Button {
                if (UserApi.isKakaoTalkLoginAvailable()) {
                    UserApi.shared.loginWithKakaoTalk {(outhToken, error) in
                        if let error = error {
                            print(error)
                        }
                    }
                } else {
                    UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                        if let error = error {
                            print(error)
                        }
                        if oauthToken != nil {
                            print("Kakao Login 성공")
                        }
                    }
                }
            } label : {
                Image("kakao_login_large_narrow")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width : UIScreen.main.bounds.width * 0.5)
            }
        }
    }
}

#Preview {
    KakaoButton()
}
