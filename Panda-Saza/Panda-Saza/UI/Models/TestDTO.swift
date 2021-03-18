//
//  Test.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/02/26.
//

import Foundation
import Combine
import SwiftUI




struct MoviesView: View {
    
    // 1
    @ObservedObject var viewModel = TestViewModel()
    
    var body: some View {
        /*
        List(viewModel.data) { data in // 2
            HStack {
                VStack(alignment: .leading) {
                    Text(String(data.dataId)) // 3a
                        .font(.headline)
                    Text(data.dataEmail) // 3b
                        .font(.subheadline)
                }
            }
        }
 */
        HStack {
            VStack(alignment: .leading) {
                Text(String(viewModel.data.dataId)) // 3a
                    .font(.headline)
                Text(viewModel.data.dataEmail) // 3b
                    .font(.subheadline)
                
                ImageView(withURL: viewModel.data.avatar, isComingFromHomepage: false)
                    .frame(width: UIScreen.screenWidth * 0.9, height: UIScreen.screenHeight / 3)
                    .background(Color(.white))
                    .border(Color.black)
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        MoviesView()
    }
}
