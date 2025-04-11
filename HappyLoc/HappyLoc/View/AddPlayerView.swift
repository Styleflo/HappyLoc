//
//  AddPlayerView.swift
//  Happyloc
//
//  Created by Florian Touraine on 10/04/2025.
//

import SwiftUI


struct AddPlayerView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var image: Data?
    
    var body: some View {
        let pm = PlayerManager(modelContext)
        Form {
            Section {
                HStack {
                    Spacer()
                    Image(systemName: "person.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .scaledToFit()
                        .frame(width: 180, height: 120)
                        .clipShape(.circle)
                        .overlay{
                            Circle().stroke(.black, lineWidth: 2)
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
            }
        }
    }
}

#Preview {
    AddPlayerView()
}
