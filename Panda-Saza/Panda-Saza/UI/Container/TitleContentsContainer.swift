//
//  TitleContentsContainer.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/13.
//

import SwiftUI

struct TitleContentsContainer<Content: View>: View {
    var content: () -> Content
    var title: String
    
    init(title: String, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.title = title
    }

    var body: some View {
        // more to come
        VStack(alignment: .leading, spacing: 25) {
            HStack {
                Text(title)
                    .font(.body)
                    .bold()
                Spacer()
            }
            
            VStack(spacing: 25, content: content)
                .font(.title3)
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 20)
    }
}

struct TitleContentsContainer_Previews: PreviewProvider {
    static var previews: some View {
        TitleContentsContainer(title: "타이틀") {
            Text("항목1")
            Text("항목2")
            Text("항목3")
        }
    }
}
