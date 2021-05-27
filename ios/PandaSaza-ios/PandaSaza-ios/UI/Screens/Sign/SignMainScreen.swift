//
//  SignMainScreen.swift
//  PandaSaza-ios
//
//  Created by 허재 on 2021/05/25.
//

import SwiftUI

struct SignMainScreen: View {
    
    @Environment(\.injected) private var injected: DIContainer
    @Environment(\.presentationMode) private var presentation
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

// Views
extension SignMainScreen {
    
    var content: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 0) {
                
            }
        }
    }
    
    
    
}

struct SignMainScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignMainScreen()
            .inject(AppEnvironment.bootstrap().container)
    }
}
