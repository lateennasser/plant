import Foundation
import Observation
import SwiftData

@Observable
class PlantViewModel {
    var plants: [Plant] = []
    private var context: ModelContext?

    var progress: Double {
        guard !plants.isEmpty else { return 0 }
        return Double(wateredCount) / Double(plants.count)
    }

    var wateredCount: Int {
        plants.filter { $0.isWatered }.count
    }

    var allWatered: Bool {
        !plants.isEmpty && wateredCount == plants.count
    }

    func setContext(_ context: ModelContext) {
        self.context = context
        plants = (try? context.fetch(FetchDescriptor<Plant>())) ?? []
    }

    func addPlant(_ plant: Plant) {
        guard !plant.name.isEmpty, let context else { return }
        context.insert(plant)
        try? context.save()
        NotificationManager.shared.scheduleReminder(for: plant)   // ←
        plants.append(plant)
    }

    func toggleWatered(_ plant: Plant) {
        plant.isWatered.toggle()
        try? context?.save()
    }

    func updatePlant(_ plant: Plant, with draft: Plant) {
        guard !draft.name.isEmpty else { return }
        plant.name = draft.name
        plant.room = draft.room
        plant.light = draft.light
        plant.wateringDays = draft.wateringDays
        plant.water = draft.water
        try? context?.save()
        NotificationManager.shared.scheduleReminder(for: plant)   // ←
    }

    func deletePlant(_ plant: Plant) {
        NotificationManager.shared.cancelReminder(for: plant)     // ←
        context?.delete(plant)
        try? context?.save()
        plants.removeAll { $0.id == plant.id }
    }
}
