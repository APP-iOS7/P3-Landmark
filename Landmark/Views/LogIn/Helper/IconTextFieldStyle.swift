//
//  IconTextFieldStyle.swift
//  Firebasecamp
//
//  Created by 김덕원 on 2/5/25.
//

import SwiftUI

struct IconTextFieldStyle: TextFieldStyle {
    var iconName: String
    
    func _body(configuration: TextField<_Label> ) -> some View {
        HStack {
            Image(systemName: iconName)
                .foregroundStyle(.white.opacity(0.85))
                .padding(.leading,10)
            
            configuration
                .foregroundStyle(.white)
                .padding(.vertical, 12)
        }
        .padding(.horizontal, 10)
        .background(.ultraThinMaterial)
        .frame(width:350, height: 40)
        .cornerRadius(15)
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(.white.opacity(0.3), lineWidth: 1)
        }
        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 4)
    }
}

