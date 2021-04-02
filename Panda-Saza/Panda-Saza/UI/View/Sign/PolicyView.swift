//
//  PolicyView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/04/01.
//

import SwiftUI

struct PolicyView: View {
    
    @Environment(\.presentationMode) var presentation
    
    let policyType: PolicyType
    
    init(policyType: PolicyType) {
        self.policyType = policyType
    }
    
    var body: some View {
        content
    }
}

extension PolicyView {
    enum PolicyType {
        case termsOfUse
        case termsOfPrivacy
    }
}

extension PolicyView {
    var content: some View {
            ZStack {
                VStack{}
                    .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
                    .background(Color.white).ignoresSafeArea()
                
                VStack(spacing: 0) {
                    self.navBar
                        .padding(.top, 60)
                    Divider()
                        .padding(.top, 10)
                    ScrollView {
                        if policyType == .termsOfPrivacy {
                            self.privacyPolicy
                        }
                        else if policyType == .termsOfUse {
                            self.usagePolicy
                        }
                    }
                }
                .background(Color.white)
            }
            
            .navigationBarHidden(true)
    }
    
    var usagePolicy: some View {
        VStack(alignment: .leading){
            Text("Terms Of Use")
                .font(.custom("NunumGothicBold", size: 30))
        }
    }
    
    var privacyPolicy: some View {
        VStack(alignment: .leading){
            Text("Privacy Policy")
                .font(.custom("NunumGothicBold", size: 30))
        }
    }
    
    var navBar: some View {
        HStack{
            Button(action: { presentation.wrappedValue.dismiss() }) {
                Image(systemName: "chevron.left")
                    .resizable()
                    .frame(width: 15, height: 25)
            }.foregroundColor(.black)
            .padding(.leading, 20)
            Spacer()
        }
    }
}

struct PolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PolicyView(policyType: .termsOfPrivacy)
    }
}
