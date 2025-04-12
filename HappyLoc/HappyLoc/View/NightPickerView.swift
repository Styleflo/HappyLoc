import SwiftUI

struct NightPickerView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var selectedDate = Date()
    var player: Player
    
    var pm: PlayerManager {
            PlayerManager(modelContext)
        }

    var body: some View {
        VStack {
            DatePicker(
                "Sélectionner une date",
                selection: $selectedDate,
                in: ...Date(), // Limite la sélection à aujourd'hui ou avant
                displayedComponents: [.date]
            )
            .datePickerStyle(.graphical)
            .padding()
            
            HStack {
                Button("OK") {
                    pm.addNight(player: player, date: selectedDate)
                    dismiss()
                }
                .padding()
                Button("Annuler") {
                    
                    dismiss()
                }
            }
            .padding()
        }
    }
}

#Preview {
    NightPickerView(player: Player(name: "Florian", score: 10, sleepScore: 2, imageData: nil))
}
