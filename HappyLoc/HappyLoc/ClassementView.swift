import SwiftUI


import Foundation

struct ClassementView: View {
    @State private var players : [Player] = []
    
    var body: some View {
        
        Button("Add") {
            players.append(Player(name:"Florian",score: 0, sleepScore: 0, profileImage: "Florian"))
        }
//        .padding(10)
//        .background(Color.white)
//        .cornerRadius(20)
//        .padding(.all, 7)
//        .background(Color.gray.opacity(0.4))
//        .cornerRadius(30)
//        .shadow(radius: 2)
//        .padding(10)
//        .background(Color.clear)
        
        if players.count == 0 {
            Text("Pas encore d'inscrits")
                .bold()
        }
        if players.count > 0 {
            List {
                ForEach($players) { $player in
                    PlayerRowView(player: player)
                }
            }
        }
    }
}

#Preview {
    ClassementView()
}
