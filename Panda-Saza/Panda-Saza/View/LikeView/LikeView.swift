//
//  LikeView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/02/24.
//

import SwiftUI

struct LikeView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var selectedTabIndex = 0
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                        Image(systemName: "chevron.left")
                            .font(Font.system(size: 15))
                    }.foregroundColor(.black)
                    .padding(.leading, 10)
                    Spacer()
                }
                Text("좋아요 / 이벤트")
                    .font(Font.system(size: 12))
                    .bold()
                    .foregroundColor(.black)
            }
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight / 20)
            
            SlidingTabView(selection: self.$selectedTabIndex,
                           tabs: ["좋아요", "이벤트"],
                           font: Font.system(size: 12).bold(),
                           activeAccentColor: Color.black,
                           selectionBarColor: Color.black)
            (selectedTabIndex == 0 ? Text("좋아요 리스트") : Text("이벤트 리스트"))
                /*
                .gesture(DragGesture(minimumDistance: 20, coordinateSpace: .global)
                            .onEnded { value in
                                let horizontalAmount = value.translation.width as CGFloat
                                _ = value.translation.height as CGFloat
                                
                                selectedTabIndex += horizontalAmount < 0 ? -1 : 1
                            })
                 */
                .animation(.none)
            Spacer()
        }
        .navigationBarHidden(true)
    }
}

struct LikeView_Previews: PreviewProvider {
    static var previews: some View {
        LikeView()
    }
}
