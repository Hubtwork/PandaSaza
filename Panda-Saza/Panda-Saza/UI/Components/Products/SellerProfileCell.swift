//
//  SellerProfileCell.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/29.
//

import SwiftUI

struct SellerProfileCell: View {
    
    @Environment(\.locale) private var locale: Locale
    @Environment(\.injected) private var injected: DIContainer
    
    let currentFont: String = "NanumGothic"
    
    let profileImageUrlString: String
    let profileImageSize: CGFloat = 35
    
    let userName: String
    let userLocale: String
    
    let schoolName: String
    
    let rating: Double
    
    
    var body: some View {
        HStack {
            HStack(spacing: 5) {
                CircleImageView(imageString: profileImageUrlString)
                    .frame(width: profileImageSize, height: profileImageSize)
                
                VStack(alignment: .leading, spacing: 3) {
                    Text(userName)
                        .font(.custom(currentFont, size: 18))
                        .bold()
                    Text(schoolName)
                        .font(Font.system(size: 15))
                        .foregroundColor(.gray)
                }.padding(.leading, 10)
            }
            Spacer()
            VStack(alignment: .leading, spacing: 3) {
                HStack {
                    Text("국적")
                        .font(.custom(currentFont, size: 18))
                        .bold()
                    Image(userLocale)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18)
                }
                HStack {
                    Text("평점")
                        .font(.custom(currentFont, size: 18))
                        .bold()
                    Image(systemName: "star.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.yellow)
                        .frame(width: 15)
                    Text(String(rating))
                        .font(.custom(currentFont, size: 15))
                        .bold()
                }
            }.padding(.trailing, 15)
            
            
        }.padding(.vertical, 10)
        .padding(.leading, 10)
    }
}

struct SellerProfileCell_Previews: PreviewProvider {
    static var previews: some View {
        SellerProfileCell(profileImageUrlString: "https://image.news1.kr/system/photos/2019/2/11/3504326/article.jpg/dims/optimize", userName: "이경섭", userLocale: "kr", schoolName: "서강대학교", rating: 3.14).previewLayout(.fixed(width: 500, height: 100))
            .inject(AppEnvironment.bootstrap().container)
    }
}
