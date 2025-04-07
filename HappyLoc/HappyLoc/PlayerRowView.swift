//
//  PlayerRowView.swift
//  HappyLoc
//
//  Created by Florian Touraine on 05/04/2025.
//
//Custom View

import SwiftUI

struct PlayerRowView: View {
    var player: Player
    var body: some View {
        HStack {
            Image(player.profileImage)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 40)
                .clipShape(.circle)
                .overlay{
                    Circle().stroke(.black, lineWidth: 2)
                }
            
            VStack(alignment: .leading) {
                Text(player.name)
                    .fontWeight(.semibold)
                Text("\(player.score) pts").font(.subheadline).foregroundStyle(.secondary)
            }
            Spacer()
            HStack {
                Text("\(player.sleepScore)")
                    .foregroundColor(.primary)
                Image(systemName: "moon.fill")
                    .foregroundColor(.yellow)
            }

            
        }
    }
}

#Preview {
    PlayerRowView(player: Player(name: "Florian", score: 10, sleepScore: 2,profileImage: "Florian"))
}
