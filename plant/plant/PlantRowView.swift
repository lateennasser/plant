import SwiftUI

struct PlantRowView: View {
    let plant: Plant
    let onToggle: () -> Void

    var body: some View {
        HStack(spacing: 14) {
            Button(action: onToggle) {
                Image(systemName: plant.isWatered ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 24))
                    .foregroundStyle(plant.isWatered ? Color.gp : .gray)
            }
            .buttonStyle(.plain)

            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 4) {
                    Image(systemName: "location")
                    Text("in \(plant.room.rawValue)")
                }
                .font(.system(size: 14))
                .foregroundStyle(.secondary)

                Text(plant.name)
                    .font(.system(size: 28))
                    .foregroundStyle(.white)

                HStack(spacing: 8) {
                    tag(plant.light.rawValue, icon: plant.light.icon, color: .Y)
                    tag(plant.water.rawValue, icon: "drop", color: .B)
                }
            }
            .opacity(plant.isWatered ? 0.4 : 1)
        }
        .padding(.vertical, 8)
    }

    private func tag(_ text: String, icon: String, color: Color) -> some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
            Text(text)
        }
        .font(.system(size: 14))
        .foregroundStyle(color)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    PlantRowView(plant: Plant(name: "Monstera", room: .kitchen)) { }
        .preferredColorScheme(.dark)
}
