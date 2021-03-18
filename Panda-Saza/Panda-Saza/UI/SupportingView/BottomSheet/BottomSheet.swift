//
//  BottomSheet.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/17.
//

import SwiftUI

public struct OverlayedBottomSheet<Content: View>: View {
    
    private var grayBackgroundOpacity: Double { isPresented ? 0.5 : 0 }

    @Binding var isPresented: Bool
    private let contentHeight: CGFloat
    private let topBarHeight: CGFloat
    private let content: Content
    private let contentBackgroundColor: Color
    private let topBarBackgroundColor: Color
    private let showTopIndicator: Bool
    
    private let title: String
    
    public init(
        isPresented: Binding<Bool>,
        contentHeight: CGFloat,
        topBarHeight: CGFloat = 30,
        topBarCornerRadius: CGFloat? = nil,
        topBarBackgroundColor: Color = Color.white,
        contentBackgroundColor: Color = Color.white,
        showTopIndicator: Bool,
        title: String,
        @ViewBuilder content: () -> Content
    ) {
        self.topBarBackgroundColor = topBarBackgroundColor
        self.contentBackgroundColor = contentBackgroundColor
        self._isPresented = isPresented
        self.contentHeight = contentHeight
        self.topBarHeight = topBarHeight
        self.showTopIndicator = showTopIndicator
        self.content = content()
        
        self.title = title
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                self.fullScreenLightGrayOverlay()
                
                VStack(spacing: 0) {
                    self.titleBar(geometry: geometry)
                    VStack(spacing: -8) {
                        Spacer()
                        self.content
                            .padding(.bottom, geometry.safeAreaInsets.bottom)
                        Spacer()
                    }
                }
                .frame(height: self.contentHeight + self.topBarHeight)
                .background(self.contentBackgroundColor)
                .animation(.interactiveSpring())
                .offset(y: self.isPresented ? (geometry.size.height/2 - self.contentHeight/2 - self.topBarHeight/2 + geometry.safeAreaInsets.bottom) : ( geometry.size.height/2 + self.contentHeight/2 + self.topBarHeight/2 + geometry.safeAreaInsets.bottom ))
            }
        }
    }
    
    fileprivate func fullScreenLightGrayOverlay() -> some View {
        Color
            .black
            .opacity(grayBackgroundOpacity)
            .edgesIgnoringSafeArea(.all)
            .animation(.interactiveSpring())
            .onTapGesture { self.isPresented = false }
    }
    
    fileprivate func titleBar(geometry: GeometryProxy) -> some View {
        ZStack {
            HStack {
                Spacer()
                Text(self.title)
                    .bold()
                Spacer()
            }.font(.system(size: 30))
            
            HStack {
                Spacer()
                Button(action: {
                    self.isPresented = false
                }) {
                    Image(systemName: "multiply")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 20)
                        .foregroundColor(.black)
                }
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 20)
        }
        .frame(width: geometry.size.width, height: self.topBarHeight)
        .background(topBarBackgroundColor)
    }
}

public extension View {
    
    func bottomSheet<Content: View>(
        isPresented: Binding<Bool>,
        contentHeight: CGFloat,
        topBarHeight: CGFloat = 70,
        topBarCornerRadius: CGFloat? = nil,
        contentBackgroundColor: Color = Color(.systemBackground),
        topBarBackgroundColor: Color = Color(.systemBackground),
        showTopIndicator: Bool = true,
        title: String,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        ZStack {
            self
            OverlayedBottomSheet(isPresented: isPresented,
                                 contentHeight: contentHeight,
                        topBarHeight: topBarHeight,
                        topBarCornerRadius: topBarCornerRadius,
                        topBarBackgroundColor: topBarBackgroundColor,
                        contentBackgroundColor: contentBackgroundColor,
                        showTopIndicator: showTopIndicator,
                        title: title, content: content)
        }
    }
    
}


struct BottomSheet: View {
    
    @State var isPresented = false
    
    var body: some View {
        VStack {
            Button(action: {
                isPresented.toggle()
            } ) {
                Text("Example")
            }
        }
        .bottomSheet(isPresented: $isPresented, contentHeight: 90, title: "타이틀") {
            VStack(alignment: .leading, spacing: 20) {
                Text("액션 1")
                Text("액션 2")
            }
            .font(.system(size: 25))
            .padding(.vertical, 10)
            .background(Color.gray)
        }
    }
}

struct BottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheet()
    }
}
