//
//  PagingImageView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/02/25.
//

import SwiftUI

struct PagingView<Content>: View where Content: View {

    @Binding var index: Int
    let maxIndex: Int
    let content: () -> Content

    @State private var offset = CGFloat.zero
    @State private var dragging = false

    init(index: Binding<Int>, maxIndex: Int, @ViewBuilder content: @escaping () -> Content) {
        self._index = index
        self.maxIndex = maxIndex
        self.content = content
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        self.content()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
                    }
                }
                .content.offset(x: self.offset(in: geometry), y: 0)
                .frame(width: geometry.size.width, alignment: .leading)
                .gesture(
                    DragGesture().onChanged { value in
                        self.dragging = true
                        self.offset = -CGFloat(self.index) * geometry.size.width + value.translation.width
                    }
                    .onEnded { value in
                        let predictedEndOffset = -CGFloat(self.index) * geometry.size.width + value.predictedEndTranslation.width
                        let predictedIndex = Int(round(predictedEndOffset / -geometry.size.width))
                        self.index = self.clampedIndex(from: predictedIndex)
                        withAnimation(.easeOut) {
                            self.dragging = false
                        }
                    }
                )
            }
            .clipped()

            PageControl(index: $index, maxIndex: maxIndex)
        }
        .border(Color(.black))
    }

    func offset(in geometry: GeometryProxy) -> CGFloat {
        if self.dragging {
            return max(min(self.offset, 0), -CGFloat(self.maxIndex) * geometry.size.width)
        } else {
            return -CGFloat(self.index) * geometry.size.width
        }
    }

    func clampedIndex(from predictedIndex: Int) -> Int {
        let newIndex = min(max(predictedIndex, self.index - 1), self.index + 1)
        guard newIndex >= 0 else { return 0 }
        guard newIndex <= maxIndex else { return maxIndex }
        return newIndex
    }
}

struct PageControl: View {
    @Binding var index: Int
    let maxIndex: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0...maxIndex, id: \.self) { index in
                Circle()
                    .fill(index == self.index ? Color.black : Color.gray.opacity(0.7))
                    .frame(width: 10, height: 10)
            }
        }
        .padding(15)
    }
}

struct PagingImageView: View {
    @State var index = 0
    
    @State private var item_description = "제조자: 구찌 \n제조국: 이태리\n수입자: 구찌코리아 Gucci\n\n에필로그 컬렉션\n블랙 가죽\n골드 톤 메탈 장식\n마이크로파이버 라이닝 및 스웨이드 방식 마감 처리\n대체 메탈 또는 크롬 프리 태닝 처리한 가죽이 주요 소재로 사용되어, 기존 공정에 비해 환경에 미치는 영향을 줄입니다.\n제조자: 구찌 \n제조국: 이태리\n수입자: 구찌코리아 Gucci\n\n에필로그 컬렉션\n블랙 가죽\n골드 톤 메탈 장식"

    var images = ["gucci_01", "gucci_02", "gucci_03"]

    var body: some View {
        /// Layer 1
        ZStack {
            ScrollView {
                /// Layer 1
                VStack(spacing: 0) {
                    PagingView(index: $index.animation(), maxIndex: images.count - 1) {
                        ForEach(self.images, id: \.self) { imageName in
                            Image(imageName)
                                .resizable()
                                .scaledToFit()
                        }
                    }
                    .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/3)
                    
                    /// Seller Profile View
                    HStack {
                        HStack(spacing: 0) {
                            CircleImageView(imageString: "gucci_02")
                                .frame(width:UIScreen.screenWidth / 6)
                            VStack(alignment: .leading, spacing: 3) {
                                Text("허진서")
                                    .font(Font.system(size: 22))
                                    .bold()
                                Text("서강대학교")
                                    .font(Font.system(size: 18))
                                    .foregroundColor(.gray)
                            }
                        }
                        Spacer()
                        VStack(alignment: .leading, spacing: 3) {
                            HStack {
                                Text("국적")
                                    .font(Font.system(size: 18))
                                    .bold()
                                Image("kr")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20)
                            }
                            HStack {
                                Text("평점")
                                    .font(Font.system(size: 18))
                                    .bold()
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.yellow)
                                    .frame(width: 18)
                                Text("3.1")
                                    .font(Font.system(size: 18))
                                    .bold()
                            }
                        }.frame(width: UIScreen.screenWidth / 3)
                        .padding(.trailing, 15)
                        
                        
                    }.padding(.vertical, 20)
                    .padding(.leading, 10)
                    
                    /// Divider
                    Divider().frame(width: UIScreen.screenWidth * 0.9)
                    
                    /// Contents Body View
                    VStack(alignment: .leading, spacing: 8) {
                        /// Item Title
                        Text("가방")
                            .font(.title2)
                            .bold()
                            .padding(.horizontal, 10)
                        /// Item Category
                        Text("가방 / 잡화")
                            .font(.body)
                            .foregroundColor(.gray)
                            .padding(.leading, 10)
                        
                        /// Item Registration Time
                        Text("15분 전")
                            .font(.body)
                            .foregroundColor(.gray)
                            .padding(.leading, 10)
                        
                        /// Item Description
                        Text(item_description)
                            .lineLimit(nil)
                            .font(.body)
                            .multilineTextAlignment(.leading)
                            .padding(10)
                        
                        /// Item Relevant Data
                        Text("채팅 7 • 찜 4 • 조회수 174")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .padding(.leading, 10)
                    }
                    .frame(width: UIScreen.screenWidth, alignment: .leading)
                    .padding(.vertical, 15)
                    Spacer()
                }
            }.ignoresSafeArea()
            
            
            /// Layer 2 Top Bar Line
            VStack {
                HStack{
                    Button(action: { print("") }) {
                        Image(systemName: "chevron.left")
                            .font(Font.system(size: UIScreen.screenWidth / 15))
                    }.foregroundColor(.black)
                    .padding([.top, .leading], 15)
                    Spacer()
                    
                }
                Spacer()
            }
            
            /// Layer 3 Bottom Bar Line
            VStack {
                Spacer()
                /// Item Price
                Text("10000 원")
            }
        }
    }
}

struct PagingImageView_Previews: PreviewProvider {
    static var previews: some View {
        PagingImageView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
            .previewDisplayName("iPhone 12 Pro Max")
    }
}
