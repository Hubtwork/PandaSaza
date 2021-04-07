//
//  BackgroundImageCarousel.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/30.
//

import SwiftUI
import Combine

struct BackgroundImageCarousel: View {
    
    private var numberOfImages: Int
    @State private var currentIndex: Int = 0
    @State private var show = false
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    private let images: [String]
    
    init(imageStrings: [String]) {
        self.images = imageStrings
        self.numberOfImages = images.count
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                if !show {
                Image(images[currentIndex])
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                    .opacity(0.8)
                    .transition(AnyTransition.opacity.animation(.easeInOut(duration:1)))
                    .onAppear() {
                        self.currentIndex = (self.currentIndex + 1) % images.count
                    }
                }
                else {
                    Image(images[currentIndex])
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                        .opacity(0.8)
                        .transition(AnyTransition.opacity.animation(.easeInOut(duration:1)))
                        .onAppear() {
                            self.currentIndex = (self.currentIndex + 1) % images.count
                        }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
            .onReceive(self.timer) { _ in
                withAnimation{
                    self.show.toggle()
                }
            }
            /**
            HStack(spacing: 0) {
                self.content
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
            .offset(x: CGFloat(self.currentIndex) * -geometry.size.width, y: 0)
            .onReceive(self.timer) { _ in
                self.currentIndex = (self.currentIndex + 1) % numberOfImages
            }
            */
        }
    }
}



struct BackgroundImageCarousel_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            BackgroundImageCarousel(imageStrings: ["bgEx1", "bgEx2", "bgEx3"])
        }.frame(height: UIScreen.screenHeight)
        .ignoresSafeArea()
    }
}
