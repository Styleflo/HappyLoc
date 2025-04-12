import SwiftUI

struct AddScoreView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var selectedDate = Date()
    @State private var info = ""
    @State private var count = 1

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
            
            Stepper("Nombre de points : \(count)", value: $count, in: 1...10)
                .font(.title2)
                .padding()
            
            TextField("quelle est la raison ?", text: $info)
                .padding()
                .frame(height: 70)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            HStack {
                Button("OK") {
                    pm.addPoint(player: player, info: info, date: selectedDate, point: count)
                    dismiss()
                }
                .disabled(info.trimmingCharacters(in: .whitespaces).isEmpty)
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
    AddScoreView(player: Player(name: "Florian", score: 10, sleepScore: 2, imageData: nil))
}
