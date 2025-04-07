import SwiftUI
import Foundation
import SwiftData

struct ClassementView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var players: [Player]

    var body: some View {
        VStack {
            Button("Add Player") {
                addPlayer()
            }

            if players.isEmpty {
                Text("Pas encore d'inscrits")
                    .bold()
            } else {
                List(players) { player in
                    PlayerRowView(player: player)
                }
            }
        }
    }
    
    private func addPlayer() {
        withAnimation {
            let newPlayer = Player(name: "Florian", score: 100, sleepScore: 2, profileImage: "Florian")
            modelContext.insert(newPlayer)
        }
    }
}

//#Preview {
//    ClassementView()
//        .modelContainer(for: Player.self, inMemory: true)  // Injection du modelContainer dans la vue
//}
