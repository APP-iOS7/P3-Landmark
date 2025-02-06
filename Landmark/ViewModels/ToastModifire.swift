//
//  ToastModifire.swift
//  Landmark
//
//  Created by 김덕원 on 2/6/25.
//

import SwiftUI

struct ToastModifire: ViewModifier {
    let message: String
    let isShowing: Bool
    
   func body(content: Content) -> some View {
       ZStack {
           content
           
           if isShowing {
               VStack {
                   Spacer()
                   Text(message)
                       .foregroundStyle(.white)
                       .padding()
                       .background(Color.black.opacity(0.8))
                       .cornerRadius(8)
                       .padding(.bottom, 40)
                       .transition(.opacity)
               }
               .animation(.easeInOut, value: isShowing)
           }
       }
    }
}

extension View {
    func toast(message: String, isShowing: Bool) -> some View {
        self.modifier(ToastModifire(message: message, isShowing: isShowing))
    }
}
