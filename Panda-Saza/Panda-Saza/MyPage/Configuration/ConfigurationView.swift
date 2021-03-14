//
//  ConfigurationView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/11.
//

import SwiftUI

struct ConfigurationView: View {
    
    @Environment(\.presentationMode) var presentation
    
    @State private var alarmBanTimeSetting = false
    @State private var alarmSound = "기본"
    @State private var systemLanguage = "한국어"
    @State private var systemVersion = "1.0.0 - Alpha"
    
    var body: some View {
        layout
    }
}

extension ConfigurationView {
    
    var layout: some View {
        VStack(spacing: 0) {
            self.titleBar
            Divider()
            ScrollView {
                VStack {
                    notifyConfigurationView
                    Divider()
                    userConfigurationView
                    Divider()
                    extraConfigurationView
                }
            }
        }.foregroundColor(Color.black)
    }
    
    var notifyConfigurationView: some View {
        TitleContentsContainer(title: "알림 설정") {
            NavigationLink(destination: PushConfigurationView()
                            .navigationBarHidden(true)) {
                HStack {
                    Text("푸시 알림 설정")
                    Spacer()
                }
            }
            HStack {
                Text("방해 금지 설정")
                Spacer()
                Toggle("방해 금지 설정",isOn: $alarmBanTimeSetting)
                    .toggleStyle(SwitchToggleStyle(tint: Color.blue))
                    .labelsHidden()
            }
            NavigationLink(destination: PushSoundConfigurationView(pushSound: $alarmSound)
                            .navigationBarHidden(true)) {
                HStack {
                    Text("알림음")
                    Spacer()
                    Text(alarmSound)
                        .foregroundColor(Color.blue)
                }
            }
        }
    }
    
    var userConfigurationView: some View {
        TitleContentsContainer(title: "사용자 설정") {
            HStack {
                Text("계정 / 정보 관리")
                Spacer()
            }
            HStack {
                Text("관심 목록 관리")
                Spacer()
            }
            HStack {
                Text("차단 목록 관리")
                Spacer()
            }
            HStack {
                Text("기타 설정")
                Spacer()
            }
        }
    }
    
    var extraConfigurationView: some View {
        TitleContentsContainer(title: "사용자 설정") {
            HStack {
                Text("언어 설정")
                Spacer()
                Text(systemLanguage)
                    .foregroundColor(Color.blue)
            }
            HStack {
                Text("버전 정보")
                Spacer()
                Text(systemVersion)
            }
            HStack {
                Text("로그아웃")
                Spacer()
            }
            HStack {
                Text("탈퇴하기")
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

struct ConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationView()
    }
}
