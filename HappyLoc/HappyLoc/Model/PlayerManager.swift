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
    
    func updatePlayer(player: Player,name: String?, score: Int?, sleepScore: Int?, ImageData: Data?) {
        player.name = name ?? player.name
        player.score = score ?? player.score
        player.sleepScore = sleepScore ?? player.sleepScore
        player.imageData = ImageData ?? player.imageData
        do {
            try modelcontext.save()
        } catch {
            print("Erreur lors de la mise à jour du joueur : \(error)")
        }
    }
    
    func addNight(player: Player, date: Date) {
        updatePlayer(player: player, name: nil, score: player.score + 10, sleepScore: player.sleepScore + 1, ImageData: nil)
        let entry1 = SleepEntry(date: date, player: player)
        modelcontext.insert(entry1)
        player.sleepEntries.append(entry1)
        do {
            try modelcontext.save()
        } catch {
            print("Erreur lors de l'ajout d'une donnée de sommeil au joueur : \(error)")
        }
    }
    
    func addPoint(player: Player, info: String, date: Date, point: Int) {
        updatePlayer(player: player, name: nil, score: player.score + point, sleepScore: nil, ImageData: nil)
        let entry1 = ScoreEntry(date: date, info: info, player: player)
        modelcontext.insert(entry1)
        player.scoreEntries.append(entry1)
        do {
            try modelcontext.save()
        } catch {
            print("Erreur lors de l'ajout d'une donnée de score au joueur : \(error)")
        }
        
    }
}
