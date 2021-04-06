//
//  SignMainView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/04/06.
//

import SwiftUI

struct SignMainView: View {
    
    @Environment(\.injected) private var injected: DIContainer
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

extension SignMainView {
    
}

struct SignMainView_Previews: PreviewProvider {
    static var previews: some View {
        SignMainView()
            .inject(AppEnvironment.bootstrap().container)
    }
}
