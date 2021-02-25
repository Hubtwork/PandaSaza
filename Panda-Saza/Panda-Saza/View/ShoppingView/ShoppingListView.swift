//
//  ShoppingList.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/02/24.
//

import SwiftUI

struct ShoppingListView: View {
    var body: some View {
        NavigationView {
            ScrollView {
            LazyVGrid(columns: [
                GridItem(.fixed(100), spacing: 40),
                GridItem(.fixed(100))
            ], alignment: .center, spacing: 10, content: {
                ForEach(0..<10, id: \.self) { num in
                    VStack(alignment: .leading) {
                        ItemThumbnailView()
                    }
                }
            })
                
            
        }
            .navigationBarHidden(true)
        }
    }
}

struct ShoppingList_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListView()
    }
}
