//
//  AuthSignUpView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/02/22.
//

import SwiftUI

struct AuthSignUpView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var id: String = ""
    @State var pw: String = ""
    
    
    @State private var gotoEmailAuthView = false
    @State private var gotoAuthMainView = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.topColor,.centerColor,.bottomColor]),
                startPoint: .topLeading, endPoint: .bottom)
            VStack{
                ZStack() {
                    HStack{
                        Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                            Image(systemName: "chevron.left")
                                .font(Font.system(size: 20))
                        }.foregroundColor(.pink)
                        .padding(.leading, 10)
                        Spacer()
                    }
                    Text("SIGN UP")
                        .font(Font.system(size: 20))
                        .foregroundColor(.pink)
                }.padding(.top, 10)
                
                VStack(alignment: .center){
                    FloatingTextField(title: "ID", text: $id)
                    FloatingTextField(title: "Email", text: $id)
                    FloatingTextField(title: "Password", text: $pw)
                    FloatingTextField(title: "Confirm Password", text: $id)
                    HStack {
                        Text("")
                    }
                        
                    Spacer()
                        
                    Text("Sign Up")
                        .bold()
                        .buttonStyleCottenCandy()
                        .frame(width: .infinity, height: 35)
                        .onTapGesture {
                            gotoEmailAuthView = true
                        }
                    
                    Spacer()
                }.frame(width: 250)
                .padding(.top, 60)
                
                
            }
        }
        .navigationBarHidden(true)
    }
}

struct AuthSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        AuthSignUpView()
    }
}
