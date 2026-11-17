import SwiftUI
import SwiftData

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            MainPage()
                .preferredColorScheme(.dark)
        }
        .modelContainer(for: Plant.self)
    }
}
