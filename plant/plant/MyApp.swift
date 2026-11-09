//
//  MyApp.swift
//  plant
//
//  Created by Lateen Nasser on 29/05/1448 AH.
//

import SwiftUI

@main
struct MyApp: App {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false

    var body: some Scene {
        WindowGroup {
            Group {
                if hasSeenOnboarding {
                    MainPage()
                } else {
                    OnboardingView()
                }
            }
            .preferredColorScheme(.dark)
        }
    }
}
