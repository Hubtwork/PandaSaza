//
//  HostingControler.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/02/22.
//

import SwiftUI

class HostingController<ContentView>: UIHostingController<ContentView> where ContentView : View {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
}
