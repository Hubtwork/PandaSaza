//
//  ContentView.swift
//  PandaSaza-ios
//
//  Created by 허재 on 2021/05/25.
//

import SwiftUI

struct ContentView: View {
    
    private let container: DIContainer
    @State private var isSigned: Bool = false
    
    init(container: DIContainer) {
        self.container = container
    }
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(container: .preview)
    }
}
