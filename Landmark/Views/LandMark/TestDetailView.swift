//
//  TestDetailView.swift
//  Landmark
//
//  Created by 김덕원 on 2/6/25.
//

import SwiftUI

struct TestDetailView: View {
    var body: some View {
        ScrollView {
            Image("TripImage") // Image 불러오는 부분
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height * 0.55)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
            
        }
        
        VStack(alignment: .leading, spacing: 10) {
            Text("Trip Image") // 제목
                .font(.title)
                .fontWeight(.bold)
                .padding(.trailing, 10)
            
            HStack {
                Text("000-0000-0000") // 전화번호
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                Spacer()
            }
            
            Text("서울시 종로구 12345") // 주소
                .font(.subheadline)
                .foregroundStyle(.gray)
                .lineLimit(3)
            
            Divider()
        }
        .padding([.horizontal, .top])
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        
        // About
        VStack(alignment: .leading, spacing: 10) {
            Text("정보")
                .font(.title2)
                .foregroundStyle(.gray)
            Text("안녕하세요 감사해요 잘있어요 다시만나요 안녕하세요 감사해요 잘있어요 다시만나요 ")
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding([.horizontal])
        
        // 좋아요 버튼
        Button(action: {
            
        } ) {
            Text("좋아요")
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(color: Color.blue.opacity(0.3), radius: 6, x: 0, y: 4)
        }
        .padding([.horizontal, .bottom])
        .padding([.horizontal])
    }
   
}
#Preview {
    TestDetailView()
}
