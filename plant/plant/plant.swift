import Foundation

struct Plant: Identifiable {
    var id = UUID()
    var name = ""
    var room: Room = .bedroom
    var light: Light = .fullSun
    var wateringDays: WateringDays = .everyDay
    var water: Water = .small
    var isWatered = false
}

enum Room: String, CaseIterable {
    case bedroom = "Bedroom"
    case livingRoom = "Living Room"
    case kitchen = "Kitchen"
    case balcony = "Balcony"
    case bathroom = "Bathroom"
}

enum Water: String, CaseIterable {
    case small = "20-50 ml"
    case medium = "50-100 ml"
    case large = "100-200 ml"
    case extraLarge = "200-300 ml"
}

enum WateringDays: String, CaseIterable {
    case everyDay = "Every day"
    case every2Days = "Every 2 days"
    case every3Days = "Every 3 days"
    case onceAWeek = "Once a week"
    case every10Days = "Every 10 days"
    case every2Weeks = "Every 2 weeks"
}

enum Light: String, CaseIterable {
    case fullSun = "Full Sun"
    case partialSun = "Partial Sun"
    case lowLight = "Low Light"

    var icon: String {
        switch self {
        case .fullSun: return "sun.max"
        case .partialSun: return "sun.haze"
        case .lowLight: return "moon"
        }
    }
}
