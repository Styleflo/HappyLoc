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
    var player: Player
    
    var pm: PlayerManager {
            PlayerManager(modelContext)
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
                            .frame(width: 180, height: 120)
                            .clipShape(.circle)
                            .overlay {
                                Circle().stroke(.black, lineWidth: 2)
                            }
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 180, height: 120)
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
                
            }
        }
    }
}

#Preview {
    PlayerView(player: Player(name: "Florian", score: 10, sleepScore: 2, imageData: nil))
}

