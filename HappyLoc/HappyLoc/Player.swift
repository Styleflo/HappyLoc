//
//  Player.swift
//  HappyLoc
//
//  Created by Florian Touraine on 05/04/2025.
//

import Foundation

struct Player: Identifiable {
    let id = UUID()
    var name: String
//    let systemimage: String
    var score: Int
    var sleepScore: Int
    var profileImage: String
}
