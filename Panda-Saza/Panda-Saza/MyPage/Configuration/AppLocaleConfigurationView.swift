//
//  AppLocaleConfigurationView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/17.
//

import SwiftUI

struct AppLocaleConfigurationView: View {
    
    @ObservedObject var viewModel: AppLocaleConfigurationViewModel = AppLocaleConfigurationViewModel()
    @Environment(\.presentationMode) var presentation
    let appLanguage: Binding<String>
    
    var body: some View {
        layout
    }
}

extension AppLocaleConfigurationView {
    var layout: some View {
        VStack(spacing: 0) {
            self.titleBar
            Divider()
            ScrollView {
                appLocaleListView
            }
        }.foregroundColor(Color.black)
    }
    
    var appLocaleListView: some View {
        VStack(alignment: .leading, spacing: 20) {
            ForEach(self.viewModel.languages!.language, id: \.self) { localeStr in
                
                    Button(action: {
                        appLanguage.wrappedValue = localeStr
                    } ) {
                        HStack {
                            Text(localeStr)
                                .font(.title3)
                                .foregroundColor(.black)
                            
                            Spacer()
                            if (self.appLanguage.wrappedValue == localeStr) {
                                Image(systemName: "checkmark")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.blue)
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
