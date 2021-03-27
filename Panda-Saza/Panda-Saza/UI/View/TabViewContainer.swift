//
//  TabViewContainer.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/27.
//

import SwiftUI
import Combine

struct TabViewContainer: View {
    
    @Environment(\.locale) private var locale: Locale
    @Environment(\.injected) private var injected: DIContainer
    
    @State private var selectedTab: Int = 0
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                switch selectedTab {
                case 0:
                    first
                case 1:
                    two
                case 2:
                    three
                case 3:
                    fourth
                default:
                    fifth
                }
                TabBar().inject(injected)
            }
        }
        .onReceive(selectedTabUpdate) {
            self.selectedTab = $0
        }
    }
}

extension TabViewContainer {
    var first: some View {
        VStack {
            Spacer()
            Text("첫번째 View")
            Spacer()
        }
    }
    var two: some View {
        VStack {
            Spacer()
            Text("두번째 View")
            Spacer()
        }
    }
    var three: some View {
        VStack {
            Spacer()
            Text("세번째 View")
            Spacer()
        }
    }
    var fourth: some View {
        VStack {
            Spacer()
            Text("네번째 View")
            Spacer()
        }
    }
    var fifth: some View {
        VStack {
            Spacer()
            Text("다섯번째 View")
            Spacer()
        }
    }
}

struct TabViewContainer_Previews: PreviewProvider {
    static var previews: some View {
        TabViewContainer().inject(.preview)
    }
}


// MARK: - Routing
extension TabViewContainer {
    struct Routing: Equatable {
        
    }
}

// MARK: - State Updates
private extension TabViewContainer {
    
    var selectedTabUpdate: AnyPublisher<Int, Never> {
        injected.appState.updates(for: \.routes.selectedTab)
    }
    
}
