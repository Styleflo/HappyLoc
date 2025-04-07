//
//  splashView.swift
//  HappyLoc
//
//  Created by Florian Touraine on 05/04/2025.
//

import SwiftUI

struct SplashView: View {
    @Binding var isActive: Bool
    let username: String

    var body: some View {
        VStack {
            Spacer()
            Text("Bonjour \(username) 👋")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .transition(.opacity)
            Spacer()
        }
        
        .onAppear {
            // Délai de 3 secondes avant de passer à la vue principale
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    isActive = false
                }
            }
        }
    }
}

#Preview {
    SplashView(isActive: .constant(true), username: "Mina")
}
