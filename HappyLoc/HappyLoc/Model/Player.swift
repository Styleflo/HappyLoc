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
    
    @Relationship(deleteRule: .cascade) var sleepEntries: [SleepEntry] = []
    @Relationship(deleteRule: .cascade) var scoreEntries: [ScoreEntry] = []
    
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
    var date: Date
    
    @Relationship(inverse: \Player.sleepEntries)
    var player: Player


    init(date: Date, player: Player) {
        self.date = date
        self.player = player
    }
}

@Model
class ScoreEntry {
    var date: Date
    var info: String
    
    @Relationship(inverse: \Player.scoreEntries)
    var player: Player

    init(date: Date, info: String, player: Player) {
        self.date = date
        self.info = info
        self.player = player
    }
}
