//
//  SleepEntryView.swift
//  Happyloc
//
//  Created by Florian Touraine on 15/04/2025.
//

import SwiftUI

struct SleepEntryView: View {
    var sleepEntry: SleepEntry
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Dormir à la coloc")
                    .fontWeight(.semibold)
                Text("10 pts")
                    .font(.subheadline).foregroundStyle(.secondary)
            }
            Spacer()
            HStack {
                Text("\(sleepEntry.date, style: .date)")
                    .foregroundColor(.primary)
                Image(systemName: "moon.fill")
                    .foregroundColor(.yellow)
            }
        }
    }
}

#Preview {
    SleepEntryView(sleepEntry: SleepEntry(date: Date(), player: Player(name: "Florian", score: 10, sleepScore: 2, imageData: nil)))
}
