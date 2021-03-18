//
//  ChattingList.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/04.
//

import SwiftUI

struct ChattingList: View {
    
    var viewModel: ChattingListViewModel
    
    var body: some View {
        layout
    }
}

extension ChattingList {
    var layout: some View {
        VStack(spacing: 0){
            titleBar
            Divider()
                .background(Color.black)
            
            chattingList(chattingList: viewModel.chattingList)
        }
    }
    
    func chattingList(chattingList: [ChattingThumbnail]) -> some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(chattingList, id: \.self) { chat in
                    ChattingThumbnailView(viewModel: ChattingThumbnailViewModel(chat: chat))
                        .padding(.vertical, 20)
                    Divider()
                }
            }
        }
    }
    
    var titleBar: some View {
        HStack {
            Spacer()
            Text("채팅")
                .font(.title2)
                .bold()
            Spacer()
        }.padding(.vertical, 10)
    }
}

struct ChattingList_Previews: PreviewProvider {
    static var previews: some View {
        ChattingList(viewModel: ChattingListViewModel())
    }
}
