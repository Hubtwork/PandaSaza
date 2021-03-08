//
//  ChattingView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/04.
//

import SwiftUI

struct ChattingThumbnailView: View {
    
    var viewModel: ChattingThumbnailViewModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            CircleImageView(imageString: viewModel.chat.partnerProfileIcon)
                .frame(width:UIScreen.screenWidth / 6, height: UIScreen.screenWidth / 6)
            VStack(spacing: 5) {
                HStack {
                    Text(viewModel.chat.partnerName)
                        .font(.title3)
                        .bold()
                    Text(calcDateDiff(baseDateTimestamp: viewModel.chat.partnerLastDateTime))
                        .font(.body)
                    Spacer()
                }
                .frame(height: UIScreen.screenWidth / 12)
                
                HStack {
                    Text(viewModel.chat.partnerLastMessage)
                        .font(.title3)
                    Spacer()
                }
                .frame(height: UIScreen.screenWidth / 12)
            }
            .padding(.leading, 10)
            
        }.padding(.horizontal, 20)
    }
}
