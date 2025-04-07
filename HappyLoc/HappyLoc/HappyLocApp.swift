//
//  HappylocApp.swift
//  Happyloc
//
//  Created by Florian Touraine on 07/04/2025.
//

import SwiftUI
import SwiftData

@main
struct HappylocApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Player.self)
    }
}
