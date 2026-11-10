import SwiftUI

struct MainPage: View {
    @State private var viewModel = PlantViewModel()
    @State private var showOnboarding = true
    @State private var showReminder = false

    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 12) {
                Text("My Plants 🌱")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundStyle(.white)

                Rectangle()
                    .fill(.white.opacity(0.2))
                    .frame(height: 1)
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)

            if viewModel.plants.isEmpty {
                Spacer()
                Text("No reminders set yet..")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.secondary)
                    .opacity(showOnboarding || showReminder ? 0 : 1)
                Spacer()
            } else {
                VStack(spacing: 14) {
                    Text(viewModel.wateredCount > 0
                         ? "\(viewModel.wateredCount) of your plants feel loved today✨"
                         : "Your plants are waiting for a sip 💦")
                        .font(.system(size: 17))
                        .foregroundStyle(.white)

                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            Capsule()
                                .fill(Color(.systemGray5))
                            Capsule()
                                .fill(Color.gp)
                                .frame(width: geo.size.width * viewModel.progress)
                        }
                    }
                    .frame(height: 8)
                    .animation(.easeInOut, value: viewModel.progress)
                }
                .padding(.horizontal, 26)
                .padding(.top, 24)
                .padding(.bottom, 16)

                List(viewModel.plants) { plant in
                    PlantRowView(plant: plant) {
                        viewModel.toggleWatered(plant)
                    }
                    .listRowBackground(Color.clear)
                }
                .listStyle(.plain)
            }
        }
        .overlay(alignment: .bottomTrailing) {
            if !showOnboarding && !showReminder {
                Button {
                    showReminder = true
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundStyle(.white)
                        .frame(width: 44, height: 44)
                        .glassEffect(.regular.tint(.gp.opacity(0.45)), in: .circle)
                }
                .padding(24)
            }
        }
        .overlay {
            if showOnboarding {
                OnboardingView(showOnboarding: $showOnboarding, showReminder: $showReminder)
            }
        }
        .sheet(isPresented: $showReminder) {
            SetReminderView(viewModel: viewModel)
        }
    }
}

#Preview {
    MainPage()
        .preferredColorScheme(.dark)
}
