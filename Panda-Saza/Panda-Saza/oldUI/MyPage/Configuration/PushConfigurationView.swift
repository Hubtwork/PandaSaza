//
//  PushConfigurationView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/14.
//

import SwiftUI


struct PushConfigurationView: View {
    
    @Environment(\.presentationMode) var presentation
    
    @State private var pushNotificationChat = true
    @State private var pushNotificationLike = true
    @State private var pushNotificationMarketing = true
    
    var body: some View {
        layout
    }
}

extension PushConfigurationView {
    
    var layout: some View {
        VStack(spacing: 0) {
            self.titleBar
            Divider()
            ScrollView {
                notificationView
            }
        }
    }
    
    var notificationView: some View {
        VStack(alignment: .leading, spacing: 20) {
            /// 채팅 알림
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text("채팅 알림")
                        .font(.title2)
                        .bold()
                    Text("채팅 메세지 알림")
                }
                Spacer()
                Toggle("채팅",isOn: $pushNotificationChat)
                    .toggleStyle(SwitchToggleStyle(tint: Color.blue))
                    .labelsHidden()
            }
            /// 좋아요 알림
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text("픽 알림")
                        .font(.title2)
                        .bold()
                    Text("댓글, 찜, 팔로우 판매자 알림")
                }
                Spacer()
                Toggle("관심",isOn: $pushNotificationLike)
                    .toggleStyle(SwitchToggleStyle(tint: Color.blue))
                    .labelsHidden()
            }
            /// 마케팅 알림
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text("마케팅 알림")
                        .font(.title2)
                        .bold()
                    Text("이벤트, 마케팅 정보 알림")
                }
                Spacer()
                Toggle("마케팅",isOn: $pushNotificationMarketing)
                    .toggleStyle(SwitchToggleStyle(tint: Color.blue))
                    .labelsHidden()
            }
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 15)
    }
    
    var titleBar: some View {
        ZStack {
            HStack {
                Button(action: { presentation.wrappedValue.dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(Font.system(size: UIScreen.screenWidth / 15))
                }.foregroundColor(.black)
                Spacer()
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 10)
            
            HStack {
                Spacer()
                Text("설정")
                    .font(.title2)
                    .bold()
                Spacer()
            }.padding(.vertical, 10)
        }
    }
    
}

struct PushConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        PushConfigurationView()
    }
}
