//
//  ScoreEntryView.swift
//  Happyloc
//
//  Created by Florian Touraine on 15/04/2025.
//

import SwiftUI

struct ScoreEntryView: View {
    var scoreEntry: ScoreEntry
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(scoreEntry.info)")
                    .fontWeight(.semibold)
                Text("\(scoreEntry.score) pts")
                    .font(.subheadline).foregroundStyle(.secondary)
            }
            Spacer()
            HStack {
                Text("\(scoreEntry.date, style: .date)")
                    .foregroundColor(.primary)
                Image(systemName: "atom")
                    .foregroundColor(.blue)
            }
        }
    }
}

#Preview {
    ScoreEntryView(scoreEntry: ScoreEntry(date: Date(), info: "bbbbbbbbbbbbbbbbbbbb", score: 7, player: Player(name: "Florian", score: 20, sleepScore: 2, imageData: nil)))
}
