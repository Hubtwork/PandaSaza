//
//  BottomTabBarItemView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/02/25.
//

import SwiftUI

struct BottomTabBarItemView: View {
    
    public let isSelected: Bool
    public let item: BottomTabBarItem
    
    @Environment(\.locale) private var locale: Locale
    
    var body: some View {
        VStack(spacing: 3) {
            Image(systemName: item.icon)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(isSelected ? Color(.black) : .init(white: 0.8))
            Text(item.title.localized(self.locale))
                .font(.system(size: 10, weight: .bold))
                .foregroundColor(isSelected ? Color(.black) : .init(white: 0.8))
        }.padding([.vertical], 5)
    }
}

struct BottomTabBarItemView_Previews: PreviewProvider {
    static var previews: some View {
        BottomTabBarItemView(isSelected: true, item: BottomTabBarItem(icon: "heart.fill", title: "찜 목록", color: Color(.red)))
    }
}
