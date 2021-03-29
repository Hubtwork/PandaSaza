//
//  ProductContentCell.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/29.
//

import SwiftUI

struct ProductContentCell: View {
    
    let currentFont: String = "NanumGothic-Regular"
    
    // UI reference
    let width: CGFloat = UIScreen.screenWidth
    
    let itemName: String
    let itemCategory: String
    let itemRegistrationTime: Double
    let itemContents: String
    
    let chatCount: Int
    let likeCount: Int
    let viewCount: Int
    
    init(itemName: String, itemCategory: String, itemRegistrationTime: Double, itemContents: String, chatCount: Int, likeCount: Int, viewCount: Int) {
        self.itemName = itemName
        self.itemCategory = itemCategory
        self.itemRegistrationTime = itemRegistrationTime
        self.itemContents = itemContents
        self.chatCount = chatCount
        self.likeCount = likeCount
        self.viewCount = viewCount
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            /// Item Title
            Text(itemName)
                .font(.custom(currentFont, size: 20))
                .bold()
            
            HStack(alignment: .center) {
                /// Item Category
                Text("\(itemCategory) • \(calcDateDiff(baseDateTimestamp: itemRegistrationTime))")
                    .font(.custom(currentFont, size: 15))
                    .foregroundColor(Color.black.opacity(0.7))
            }
            
            /// Item Description
            Text(itemContents)
                .lineLimit(nil)
                .lineSpacing(5)
                .font(.body)
                .multilineTextAlignment(.leading)
            
            /// Item Relevant Data
            HStack(spacing: 5){
                Spacer()
                HStack(spacing: 3) {
                    if (chatCount > 0) {
                        Text("채팅 \(chatCount) • ")
                    }
                }
                HStack(spacing: 3) {
                    if (likeCount > 0) {
                        Text("찜 \(likeCount) • ")
                    }
                }
                HStack(spacing: 3) {
                    Text(String(format: "%@ %d", "조회수", viewCount))
                }
            }.font(.custom(currentFont, size: 15))
            .foregroundColor(Color.black.opacity(0.7))
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 15)
        .frame(width: width, alignment: .leading)
    }
}

struct ProductContentCell_Previews: PreviewProvider {
    static var previews: some View {
        ProductContentCell(itemName: "구찌 핸드백 ( 18년도에 사서 10번 정도 사용했음 )", itemCategory: "악세서리", itemRegistrationTime: 1614129326, itemContents: "GG 마몽 소프트 스트럭처드 체인 미니 백. 백에 부착하거나 크기가 큰 별도의 백에 부착할 수 있는 키링, 플랩 잠금장치 및 더블 G 메탈 장식. 구찌의 1970년대 디자인 아카이브에서 영감을 받은 메탈 장식. 마틀라세 쉐브론 가죽으로 제작.\n2018 캐리오버 컬렉션\n제조자: 구찌\n제조국: 이태리\n수입자: 구찌코리아\n블랙 마틀라세 쉐브론 가죽 및 블랙 가죽 디테일\n골드 톤 메탈 장식\n개별 백에 부착할 수 있는 탈부착식 키링\n더블 G\n체인 숄더 스트랩, 60cm 드롭\n이 상품은 최대 가로 69mm x 세로 147mm x 너비 7mm 크기의 휴대전화를 넣을 수 있습니다.\n스트랩 길이: 123cm", chatCount: 1, likeCount: 3, viewCount: 32)
    }
}
