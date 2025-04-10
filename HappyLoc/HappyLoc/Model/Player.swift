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
    
    
    init(name: String, score:Int, sleepScore:Int, imageData: Data?) {
        self.id = UUID()
        self.name = name
        self.score = score
        self.sleepScore = sleepScore
        self.imageData = imageData
        
    }
}
