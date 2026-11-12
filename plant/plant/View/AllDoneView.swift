import SwiftUI

struct AllDoneView: View {
    var body: some View {
        VStack(spacing: 8) {
            Image("wink")
                .resizable()
                .scaledToFit()
                .frame(width: 220, height: 220)
                .padding(.bottom, 30)

            Text("All Done! 🎉")
                .font(.system(size: 25, weight: .bold))
                .foregroundStyle(.white)

            Text("All Reminders Completed")
                .font(.system(size: 16, weight: .regular))
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    AllDoneView()
        .preferredColorScheme(.dark)
}
