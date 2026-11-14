import Foundation
import Observation
import SwiftData

@Observable
class PlantViewModel {
    var plants: [Plant] = []
    private var context: ModelContext?
    private let testMode = true   // ← رجعيها false بعد التجربة

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
        resetWateringIfNeeded()
        plants.forEach { NotificationManager.shared.scheduleReminder(for: $0) }
    }

    func addPlant(_ plant: Plant) {
        guard !plant.name.isEmpty, let context else { return }
        context.insert(plant)
        try? context.save()
        NotificationManager.shared.scheduleReminder(for: plant)
        plants.append(plant)
    }

    func toggleWatered(_ plant: Plant) {
        plant.isWatered.toggle()
        plant.lastWateredDate = plant.isWatered ? .now : nil
        try? context?.save()
        NotificationManager.shared.scheduleReminder(for: plant)
    }

    func resetWateringIfNeeded() {
        let calendar = Calendar.current

        for plant in plants where plant.isWatered {
            guard let last = plant.lastWateredDate else { continue }
            var shouldReset = false

            if testMode {
                // تجربة: بعد دقيقة
                shouldReset = Date.now.timeIntervalSince(last) >= 60
            } else {
                // الحقيقي: حسب أيام النبتة
                let lastDay = calendar.startOfDay(for: last)
                let today = calendar.startOfDay(for: .now)
                let daysPassed = calendar.dateComponents([.day], from: lastDay, to: today).day ?? 0
                shouldReset = daysPassed >= plant.wateringDays.days
            }

            if shouldReset {
                plant.isWatered = false
            }
        }
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
        NotificationManager.shared.scheduleReminder(for: plant)
    }

    func deletePlant(_ plant: Plant) {
        NotificationManager.shared.cancelReminder(for: plant)
        context?.delete(plant)
        try? context?.save()
        plants.removeAll { $0.id == plant.id }
    }
}
