import Foundation
import SwiftData
@Model
class Plant {
    var name: String
    var room: Room
    var light: Light
    var wateringDays: WateringDays
    var water: Water
    var isWatered: Bool
    var notificationID: String = UUID().uuidString

    init(name: String = "", room: Room = .bedroom, light: Light = .fullSun,
         wateringDays: WateringDays = .everyDay, water: Water = .small, isWatered: Bool = false) {
        self.name = name
        self.room = room
        self.light = light
        self.wateringDays = wateringDays
        self.water = water
        self.isWatered = isWatered
    }
}

enum Room: String, CaseIterable, Codable {
    case bedroom = "Bedroom"
    case livingRoom = "Living Room"
    case kitchen = "Kitchen"
    case balcony = "Balcony"
    case bathroom = "Bathroom"
}

enum Water: String, CaseIterable, Codable {
    case small = "20-50 ml"
    case medium = "50-100 ml"
    case large = "100-200 ml"
    case extraLarge = "200-300 ml"
}

enum WateringDays: String, CaseIterable, Codable {
    case everyDay = "Every day"
    case every2Days = "Every 2 days"
    case every3Days = "Every 3 days"
    case onceAWeek = "Once a week"
    case every10Days = "Every 10 days"
    case every2Weeks = "Every 2 weeks"
    var days: Int {
        switch self {
        case .everyDay: return 1
        case .every2Days: return 2
        case .every3Days: return 3
        case .onceAWeek: return 7
        case .every10Days: return 10
        case .every2Weeks: return 14
        }
    }
}

enum Light: String, CaseIterable, Codable {
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
