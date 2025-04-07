//
//  ContentView.swift
//  HappyLoc
//
//  Created by Florian Touraine on 05/04/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var showSplash = true
    let username = "Mina"

    var body: some View {
        Group {
            if showSplash {
                SplashView(isActive: $showSplash, username: username)
            } else {
                ClassementView()
            }
        }
    }
}

#Preview {
    ContentView()
}
