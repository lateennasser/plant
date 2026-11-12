import SwiftUI

struct OnboardingView: View {
    @Binding var showOnboarding: Bool
    @Binding var showReminder: Bool

    var body: some View {
        VStack(spacing: 37) {
            Image("Happy")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)

            VStack(spacing: 25) {
                Text("Start your plant journey!")
                    .font(.system(size: 25, weight: .semibold))
                    .foregroundStyle(.primary)

                Text("Now all your plants will be in one place and we will help you take care of them :)🪴")
                    .font(.system(size: 16, weight: .regular))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 45)
            }

            Button {
                showOnboarding = false
                showReminder = true
            } label: {
                Text("Set Plant Reminder")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundStyle(.white)
                    .frame(width: 280, height: 44)
                    .glassEffect(.regular.tint(.gp.opacity(0.45)), in: .capsule)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentShape(Rectangle())
    }
}

#Preview {
    OnboardingView(showOnboarding: .constant(true), showReminder: .constant(false))
        .preferredColorScheme(.dark)
}
