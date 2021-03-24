//
//  SlidingTabItem.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/11.
//

import SwiftUI

struct TabsContainer <Content : View> : View {
    let titles: [String]?
    let content: Content
    
     init(titles: [String]?, @ViewBuilder content: () -> Content) {
        self.titles = titles
        self.content = content()
    }
    
    var body: some View {
    // UI Elements
        VStack {
            
        }
    }
}


struct SlidingTab: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SlidingTab_Previews: PreviewProvider {
    static var previews: some View {
        SlidingTab()
    }
}
