import SwiftUI
import SwiftData

struct MainPage: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = PlantViewModel()
    @State private var showOnboarding = true
    @State private var showReminder = false
    @State private var plantToEdit: Plant?
    @State private var showAllDone = false

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
            } else if showAllDone {
                Spacer()
                AllDoneView()
                    .transition(.opacity.combined(with: .scale(scale: 0.9)))
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
                    .contentShape(Rectangle())
                    .onTapGesture {
                        plantToEdit = plant
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            viewModel.deletePlant(plant)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
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
        .sheet(item: $plantToEdit) { plant in
            SetReminderView(viewModel: viewModel, plantToEdit: plant)
        }
        .onAppear {
            viewModel.setContext(modelContext)
            showAllDone = viewModel.allWatered
        }
        .onChange(of: viewModel.allWatered) { _, isDone in
            if isDone {
                Task {
                    try? await Task.sleep(for: .seconds(0.8))
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showAllDone = viewModel.allWatered
                    }
                }
            } else {
                withAnimation {
                    showAllDone = false
                }
            }
        
        }
    }
}

#Preview {
    MainPage()
        .preferredColorScheme(.dark)
        .modelContainer(for: Plant.self, inMemory: true)
}
