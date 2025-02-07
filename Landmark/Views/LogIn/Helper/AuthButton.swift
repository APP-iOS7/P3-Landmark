//
//  AuthButton.swift
//  Firebasecamp
//
//  Created by 김덕원 on 2/5/25.
//

import SwiftUI

struct AuthButton: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(.title3, design: .rounded, weight: isSelected ? .semibold :
                        .regular))
                .foregroundStyle(isSelected ? .white :
                        .black.opacity(0.4))
                .padding(.vertical, 12)
                .padding(.horizontal, isSelected ? 24 : 18)
                .background(
                    isSelected
                    ?
                    AnyView(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.blue)
                    )
                    :
                        AnyView(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.ultraThinMaterial)
                        )
                )
        }
    }
}
