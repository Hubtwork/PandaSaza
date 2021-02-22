//
//  AuthLoginView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/02/22.
//

import SwiftUI

struct AuthSignInView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var id: String = ""
    @State var pw: String = ""

    @State private var gotoMainView = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.topColor,.centerColor,.bottomColor]),
                                       startPoint: .topLeading,
                                       endPoint: .bottom)
            VStack {
                ZStack() {
                    HStack{
                        Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                            Image(systemName: "chevron.left")
                                .font(Font.system(size: 20))
                        }.foregroundColor(.pink)
                        .padding(.leading, 10)
                        Spacer()
                    }
                }.padding(.top, 10)
                VStack(alignment: .center, spacing: 10){
                    Spacer()
                    FloatingTextField(title: "ID", text: $id)
                    FloatingTextField(title: "Password", text: $pw)
                    
                    VStack{
                        Text("Forgot Password?")
                            .foregroundColor(.black)
                            .font(Font.system(size: 15))
                            .overlay(
                                Rectangle().frame(height: 1).offset(y: 2)
                                , alignment: .bottom)
                    }.frame(width: 250, alignment: .trailing)
                    .padding(.top, 10)
                    Spacer()
                    
                    Text("Sign In")
                        .bold()
                        .buttonStyleThistle()
                        .frame(width: .infinity, height: 35)
                    
                    Spacer()
                }.frame(width: 250)
            }
        }
        
        .navigationBarHidden(true)
    }
}

struct AuthLoginView_Previews: PreviewProvider {
    static var previews: some View {
        AuthSignInView()
    }
}
