//
//  PushSoundConfigurationView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/14.
//

import SwiftUI

struct PushSoundConfigurationView: View {
    
    @ObservedObject var viewModel: PushSoundConfigurationViewModel = PushSoundConfigurationViewModel()
    @Environment(\.presentationMode) var presentation
    let pushSound: Binding<String>
    
    var body: some View {
        layout
    }
}

extension PushSoundConfigurationView {
    
    var layout: some View {
        VStack(spacing: 0) {
            self.titleBar
            Divider()
            ScrollView {
                notificationSoundsView
            }
        }.foregroundColor(Color.black)
    }
    
    var notificationSoundsView: some View {
        VStack(alignment: .leading, spacing: 20) {
            ForEach(self.viewModel.sounds!.sound, id: \.self) { soundStr in
                
                    Button(action: {
                        pushSound.wrappedValue = soundStr
                    } ) {
                        HStack {
                            Text(soundStr)
                                .font(.title3)
                                .foregroundColor(.black)
                            
                            Spacer()
                            if (self.pushSound.wrappedValue == soundStr) {
                                Image(systemName: "checkmark")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                    .frame(width: 20)
                            }
                        }
                    }
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
