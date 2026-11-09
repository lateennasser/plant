//
//  MyApp.swift
//  plant
//
//  Created by Lateen Nasser on 29/05/1448 AH.
//

import SwiftUI

@main
struct PlantApp: App {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false

    var body: some Scene {
        WindowGroup {
            if hasSeenOnboarding {
                MainPage()
            } else {
                OnboardingView()
            }
        }
    }
}
