//
//  ConfigurationMenuView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/11.
//

import SwiftUI

struct ConfigurationMenuView: View {
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        layout
    }
}

extension ConfigurationMenuView {
    
    var layout: some View {
        VStack {
            self.titleBar
            
            ScrollView {
                VStack {
                    notifyConfigurationView
                }
            }
        }
    }
    
    var notifyConfigurationView: some View {
        TitleContentsContainer(title: "알림 설정") {
            HStack {
                Text("푸시 알림 설정")
                    .font(.title2)
                Spacer()
            }
            HStack {
                Text("방해 금지 설정")
                    .font(.title2)
                Spacer()
            }
        }
    }
    
    var titleBar: some View {
        ZStack {
            HStack {
                Button(action: { presentation.wrappedValue.dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(Font.system(size: UIScreen.screenWidth / 15))
                }.foregroundColor(.black)
                Spacer()
            }.padding(.vertical, 10)
            .padding(.horizontal, 10)
            
            HStack {
                Spacer()
                Text("구매내역")
                    .font(.title2)
                    .bold()
                Spacer()
            }.padding(.vertical, 10)
        }
    }
    
}

struct ConfigurationMenuView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationMenuView()
    }
}
