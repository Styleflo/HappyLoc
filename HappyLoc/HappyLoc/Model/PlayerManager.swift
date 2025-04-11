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
    
    func deletePlayer(id: UUID) {
        let descriptor = FetchDescriptor<Player>(predicate: #Predicate { $0.id == id })
        
        do {
            if let player = try modelcontext.fetch(descriptor).first {
                modelcontext.delete(player)
            } else {
                print("Aucun joueur trouvé avec l’ID : \(id)")
            }
        } catch {
            print("Erreur lors de la suppression du joueur : \(error)")
        }
    }
    
    func deletePlayer(player: Player) {
        modelcontext.delete(player)
    }
}
