//
//  AuthNoticeView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/08.
//

import SwiftUI

struct AuthNoticeView: View {
    
    var auth = "[ 공지 ] 학생증 인증을 하신 후 상품 구매, 판매 정상이용 가능합니다"
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(auth)
                .font(.body)
                .foregroundColor(.white)
        }.padding(.horizontal, 10)
        .padding(.vertical, 15)
        .background(Color.orange.opacity(0.9))
    }
}

struct AuthNoticeView_Previews: PreviewProvider {
    static var previews: some View {
        AuthNoticeView()
    }
}
