//
//  EntryType.swift
//  Happyloc
//
//  Created by Florian Touraine on 15/04/2025.
//

import SwiftUI

enum EntryType: Identifiable {
    case score(ScoreEntry)
    case sleep(SleepEntry)

    var id: UUID {
        switch self {
        case .score(let entry): return entry.id
        case .sleep(let entry): return entry.id
        }
    }

    var date: Date {
        switch self {
        case .score(let entry): return entry.date
        case .sleep(let entry): return entry.date
        }
    }
}
