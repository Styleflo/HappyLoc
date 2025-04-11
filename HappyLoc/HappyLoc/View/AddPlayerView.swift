//
//  AddPlayerView.swift
//  Happyloc
//
//  Created by Florian Touraine on 10/04/2025.
//

import SwiftUI
import PhotosUI


struct AddPlayerView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var image: Data?
    @State private var phtotoPickerItem: PhotosPickerItem?
    
    var body: some View {
        let pm = PlayerManager(modelContext)
        Form {
            Section {
                HStack {
                    Spacer()
                    PhotosPicker(selection: $phtotoPickerItem, matching: .images) {
                        if let image,
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
                                image = data
                            }
                        }
                    }


                    Spacer()
                }
                
                TextField("Prénom", text: $name)
                    .autocapitalization(.words)
                
                HStack {
                    Spacer()
                    Button("Submit") {
                        pm.addPlayer(name: name, score: 10, sleepScore: 0, ImageData: image)
                        dismiss()
                    }
                    .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    Button("Annuler") {
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    AddPlayerView()
}
