//
//  PlayerManager.swift
//  Happyloc
//
//  Created by Florian Touraine on 08/04/2025.
//

import SwiftData
import Foundation

class PlayerManager: ObservableObject {
    var modelcontext: ModelContext
    
    init(_ modelcontext: ModelContext) {
        self.modelcontext = modelcontext
    }
    
    func addPlayer(name: String, score: Int, sleepScore: Int, ImageData: Data?) {
        let newPlayer = Player(name: name, score: score, sleepScore: sleepScore, imageData:ImageData)
        modelcontext.insert(newPlayer)
    }
    
    func getAllPlayer() -> [Player] {
        let descriptor = FetchDescriptor<Player>()
        
        do {
            return try modelcontext.fetch(descriptor)
        } catch {
            print("Erreur lors de la récuperation des players: \(error)")
            return []
        }
    }
}
