//
//  player.swift
//  Happyloc
//
//  Created by Florian Touraine on 07/04/2025.
//

import Foundation
import SwiftData

@Model
final class Player {
    var id: UUID
    var name: String
    var score: Int
    var sleepScore: Int
    var imageData: Data?
    
    @Relationship(deleteRule: .cascade)
        var sleepEntries: [SleepEntry] = []
        
    @Relationship(deleteRule: .cascade)
        var scoreEntries: [ScoreEntry] = []
    
    init(name: String, score:Int, sleepScore:Int, imageData: Data?) {
        self.id = UUID()
        self.name = name
        self.score = score
        self.sleepScore = sleepScore
        self.imageData = imageData
        
    }
}

@Model
class SleepEntry {
    var id: UUID
    var date: Date
    var player: Player


    init(date: Date, player: Player) {
        self.id = UUID()
        self.date = date
        self.player = player
    }
}

@Model
class ScoreEntry {
    var id: UUID
    var date: Date
    var info: String
    var score: Int
    var player: Player

    init(date: Date, info: String, score: Int, player: Player) {
        self.id = UUID()
        self.date = date
        self.info = info
        self.score = score
        self.player = player
    }
}
