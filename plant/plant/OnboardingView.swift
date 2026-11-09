//
//  OnboardingView.swift
//  plant
//
//  Created by Lateen Nasser on 29/05/1448 AH.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        VStack(spacing: 37) {
            Image("Happy")
                .frame(width: 200, height: 200)

            VStack(spacing: 25) {
                Text("Start your plant journey!")
                    .font(.system(size: 25, weight: .semibold))
                    .foregroundStyle(.primary)

                Text("Now all your plants will be in one place and we will help you take care of them :)🪴")
                    .font(.system(size: 16, weight: .regular))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 45)
                
            }
            Button {
              
            } label: {
                Text("Set Plant Reminder")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(width: 280, height: 44)
                    .glassEffect(.regular.tint(.gp).interactive(), in: .capsule)
            }
        }
        
    }
}

#Preview {
    OnboardingView()
            .preferredColorScheme(.dark)
}
