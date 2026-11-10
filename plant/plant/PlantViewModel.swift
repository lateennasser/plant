import SwiftUI

@Observable
class PlantViewModel {
    var plants: [Plant] = []

    var progress: Double {
        guard !plants.isEmpty else { return 0 }
        return Double(wateredCount) / Double(plants.count)
    }

    var wateredCount: Int {
        plants.filter { $0.isWatered }.count
    }

    func addPlant(_ plant: Plant) {
        guard !plant.name.isEmpty else { return }
        plants.append(plant)
    }

    func toggleWatered(_ plant: Plant) {
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants[index].isWatered.toggle()
        }
    }
}
