import SwiftUI

struct SetReminderView: View {
    @Environment(\.dismiss) private var dismiss
    var viewModel: PlantViewModel

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
                            Text(light.rawValue).tag(light)                        }
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
                        viewModel.addPlant(plant)
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                            .foregroundStyle(.white)
                    }
                    .buttonStyle(.glassProminent)
                    .tint(.gp.opacity(0.45))
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
    SetReminderView(viewModel: PlantViewModel())
        .preferredColorScheme(.dark)
}
