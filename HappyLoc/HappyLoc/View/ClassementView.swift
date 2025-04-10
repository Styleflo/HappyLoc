import SwiftUI
import Foundation
import SwiftData

struct ClassementView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var players: [Player]

    var body: some View {
        let pm = PlayerManager(modelContext)
        VStack {
            Button("Add Player") {
                pm.addPlayer(name: "Ewan", score: 27, sleepScore: 0, ImageData: nil)
            }

            if players.isEmpty {
                Text("Pas encore d'inscrits")
                    .bold()
            } else {
                List(players.sorted(by: { $0.score >= $1.score })) { player in
                    PlayerRowView(player: player)
                }
            }
        }
    }
    private func f () {
        
    }
}

#Preview {
    ClassementView()
        .modelContainer(for: Player.self, inMemory: true)
}
