//
//  PlayerView.swift
//  Happyloc
//
//  Created by Florian Touraine on 10/04/2025.
//

import SwiftUI
import PhotosUI

struct PlayerView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var phtotoPickerItem: PhotosPickerItem?
    @State private var editedName: String = ""
    var player: Player
    var pm: PlayerManager {
            PlayerManager(modelContext)
        }
    
    init(player: Player) {
            self.player = player
            _editedName = State(initialValue: player.name)
        }
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                PhotosPicker(selection: $phtotoPickerItem, matching: .images) {
                    if let image = player.imageData,
                       let uiImage = UIImage(data: image) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(.circle)
                            .overlay {
                                Circle().stroke(.black, lineWidth: 2)
                            }
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .clipShape(.circle)
                            .foregroundColor(.blue)
                            .overlay {
                                Circle().stroke(.blue, lineWidth: 2)
                            }
                    }
                }
                .onChange(of: phtotoPickerItem) {
                    Task {
                        if let data = try? await phtotoPickerItem?.loadTransferable(type: Data.self) {
                            pm.updatePlayer(player: player, name: nil, score: nil, sleepScore: nil, ImageData: data)
                        }
                    }
                }
                
                VStack(alignment: .leading) {
                    TextField("\(player.name)", text: $editedName, onCommit: {
                        pm.updatePlayer(player: player, name: editedName, score: nil, sleepScore: nil, ImageData: nil)
                    })
                    .font(.largeTitle.bold())
                    
                    HStack() {
                        Text("\(player.score) pts")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        
                        Text("\(player.sleepScore) nuits")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                    }
                    
                    
                }
                
                Spacer()
            }
            
            HStack {
                Button(action: {pm.updatePlayer(player: player, name: nil, score: player.score + 10, sleepScore: player.sleepScore + 1, ImageData: nil)}) {
                    Label("Nuit", systemImage: "moon.fill")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .cornerRadius(12)
                }
                
                Spacer()
                
                Button(action: {pm.updatePlayer(player: player, name: nil, score: player.score + 10, sleepScore: nil, ImageData: nil)}) {
                    Label("points", systemImage: "atom")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(12)
                }
                
            }
            .padding()
            Spacer()
        }
        .padding(30)
    }
}

#Preview {
    PlayerView(player: Player(name: "Florian", score: 20, sleepScore: 2, imageData: nil))
}

