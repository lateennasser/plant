//
//  SettingPlant.swift
//  plant
//
//  Created by Lateen Nasser on 30/05/1448 AH.
//

import SwiftUI

struct MainPage: View {
    @State private var plants: [String] = []
    @State private var showOnboarding = false
    @State private var showReminder = false

    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 12) {
                Text("My Plants 🌱")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundStyle(.white)

                Rectangle()
                    .fill(.white.opacity(0.2))
                    .frame(height: 1)
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)

            if plants.isEmpty {
                Spacer()
                Text("No reminders set yet..")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.secondary)
                Spacer()
            } else {
                List(plants, id: \.self) { plant in
                    Text(plant)
                }
            }
        }
        .overlay(alignment: .bottomTrailing) {
            Button {
                showReminder = true
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundStyle(.white)
                    .frame(width: 44, height: 44)
                    .glassEffect(.regular.tint(.gp.opacity(0.45)).interactive(), in: .circle)
            }
            .padding(24)
        }
        .onAppear {
            showOnboarding = true
        }
        .fullScreenCover(isPresented: $showOnboarding) {
            OnboardingView()
        }
        .sheet(isPresented: $showReminder) {
            SetReminderView()
        }
    }
}

#Preview {
    MainPage()
        .preferredColorScheme(.dark)
}
