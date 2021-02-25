//
//  ShoppingHomeView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/02/24.
//

import SwiftUI

struct ShoppingHomeView: View {
    var body: some View {
        VStack(spacing: 0){
            HStack {
                Spacer()
                NavigationLink(destination: SearchView()) {
                    Image(systemName: "magnifyingglass")
                }
                NavigationLink(destination: LikeView()) {
                    Image(systemName: "suit.heart")
                }
            }.padding(.trailing, 10)
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight / 20)
            .foregroundColor(.black)
            
            Divider()
            ShoppingListView()
        }
        
        .navigationBarHidden(true)
    }
}

struct ShoppingHomeView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingHomeView()
    }
}
