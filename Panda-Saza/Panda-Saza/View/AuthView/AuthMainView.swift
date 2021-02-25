//
//  LoginView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/02/22.
//

import SwiftUI

struct AuthMainView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var inputText: String = ""
    @State private var gotoSignUpView = false
    
    var body: some View {
        NavigationView{
            ZStack {
                /*
                LinearGradient(gradient: Gradient(colors: [.topColor,.centerColor,.bottomColor]),
                    startPoint: .topLeading, endPoint: .bottom)
            */
                VStack(alignment: .center, spacing:40) {
                    ZStack{
                        HStack{
                            Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                                Image(systemName: "chevron.left")
                                    .font(Font.system(size: 15))
                            }.foregroundColor(.black)
                            .padding(.leading, 10)
                            Spacer()
                        }
                    }
                    Spacer()
                    Text("판다사자")
                        .frame(width: 200, height: 60)
                        .border(Color.black, width: 2)
                        .foregroundColor(Color.black)
                        .font(Font.system(size: 40))
                    Spacer()
                    VStack {
                        NavigationLink(destination: AuthSignInView()) {
                            Text("Sign In")
                                .bold()
                                .buttonStyleThistle()
                                .frame(width: 200, height: 35)
                        }
                        
                        LabelledDivider(label: "or")
                        
                        NavigationLink(destination: AuthSignUpView()) {
                            Text("Sign up")
                                .bold()
                                .buttonStyleCottenCandy()
                                .frame(width: 200, height: 35)
                        }
                        
                    }.padding(20)
                    Spacer()
                }
            }
            
            .navigationBarHidden(true)
        }
            
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        AuthMainView()
    }
}
