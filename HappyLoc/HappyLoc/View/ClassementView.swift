import SwiftUI
import Foundation
import SwiftData

struct ClassementView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var players: [Player]
    
    @State private var showingAddView = false
    @State private var searchText = ""
    @State private var selectedSort: SortOption = .score
    
    enum SortOption: String, CaseIterable, Identifiable {
        case score = "Score"
        case sleepScore = "nuit"
        case name = "Nom"
        
        var id: String { self.rawValue }
    }
    
    var filteredPlayers: [Player] {
        let filtered = searchText.isEmpty
            ? players
            : players.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                "\($0.score)".contains(searchText) ||
                "\($0.sleepScore)".contains(searchText)
            }
        
        switch selectedSort {
        case .score:
            return filtered.sorted {
                if $0.score == $1.score {
                    return $0.name < $1.name
                }
                return $0.score > $1.score
            }
        case .sleepScore:
            return filtered.sorted {
                if $0.sleepScore == $1.sleepScore {
                    return $0.name < $1.name
                }
                return $0.sleepScore > $1.sleepScore
            }
        case .name:
            return filtered.sorted(by: { $0.name < $1.name })
        }
    }


    var body: some View {
        NavigationView {
            VStack {
                if players.isEmpty {
                    Text("Pas encore d'inscrits")
                        .bold()
                        .font(.title2)
                }
                else {
                    List {
                        ForEach(filteredPlayers) { player in
                            NavigationLink(destination: PlayerView(player: player)){
                                PlayerRowView(player: player)
                            }
                        }
                        .onDelete { indexSet in
                            withAnimation {
                                for index in indexSet {
                                    let sortedPlayers = players.sorted(by: { $0.score >= $1.score })
                                    let playerToDelete = sortedPlayers[index]
                                    let pm = PlayerManager(modelContext)
                                    pm.deletePlayer(player: playerToDelete)
                                }
                            }
                        }
                    }
                    .searchable(text: $searchText)
                }
            }
            .navigationTitle("HappyLoc")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddView.toggle()
                    } label: {
                        Label("Add Player", systemImage: "plus.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {
                        Picker("Trier par", selection: $selectedSort) {
                            ForEach(SortOption.allCases) { option in
                                Text(option.rawValue).tag(option)
                            }
                        }
                    } label: {
                        Label("Trier", systemImage: "slider.horizontal.3")
                    }
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddPlayerView()
            }
        }
        .navigationViewStyle(.stack)
        
    }
}

#Preview {
    ClassementView()
        .modelContainer(for: Player.self, inMemory: true)
}
