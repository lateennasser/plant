import SwiftUI
import SwiftData

struct SetReminderView: View {
    @Environment(\.dismiss) private var dismiss
    var viewModel: PlantViewModel
    var plantToEdit: Plant? = nil

    @State private var plant = Plant()

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Text("Plant Name")
                        TextField("Pothos", text: $plant.name)
                            .tint(.gp)
                    }
                }

                Section {
                    Picker(selection: $plant.room) {
                        ForEach(Room.allCases, id: \.self) { room in
                            Text(room.rawValue).tag(room)
                        }
                    } label: {
                        rowLabel("Room", icon: "location")
                    }
                    .tint(.gray)

                    Picker(selection: $plant.light) {
                        ForEach(Light.allCases, id: \.self) { light in
                            Text(light.rawValue).tag(light)
                        }
                    } label: {
                        rowLabel("Light", icon: "sun.max")
                    }
                    .tint(.gray)
                }

                Section {
                    Picker(selection: $plant.wateringDays) {
                        ForEach(WateringDays.allCases, id: \.self) { day in
                            Text(day.rawValue).tag(day)
                        }
                    } label: {
                        rowLabel("Watering Days", icon: "drop")
                    }
                    .tint(.gray)

                    Picker(selection: $plant.water) {
                        ForEach(Water.allCases, id: \.self) { water in
                            Text(water.rawValue).tag(water)
                        }
                    } label: {
                        rowLabel("Water", icon: "drop")
                    }
                    .tint(.gray)
                }

                if let plantToEdit {
                    Section {
                        Button(role: .destructive) {
                            viewModel.deletePlant(plantToEdit)
                            dismiss()
                        } label: {
                            Text("Delete Reminder")
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
            }
            .navigationTitle("Set Reminder")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        if let plantToEdit {
                            viewModel.updatePlant(plantToEdit, with: plant)
                        } else {
                            viewModel.addPlant(plant)
                        }
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                            .foregroundStyle(.white)
                    }
                    .buttonStyle(.glassProminent)
                    .tint(.gp.opacity(0.45))
                }
            }
            .onAppear {
                if let plantToEdit {
                    plant = Plant(name: plantToEdit.name,
                                  room: plantToEdit.room,
                                  light: plantToEdit.light,
                                  wateringDays: plantToEdit.wateringDays,
                                  water: plantToEdit.water)
                }
            }
        }
    }

    private func rowLabel(_ title: String, icon: String) -> some View {
        Label {
            Text(title)
                .foregroundStyle(.white)
        } icon: {
            Image(systemName: icon)
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: Plant.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    SetReminderView(viewModel: PlantViewModel())
        .preferredColorScheme(.dark)
        .modelContainer(container)
}
