import SwiftUI

/// A circular “Lap” button for the stopwatch
struct LapButton: View {
    /// Whether the timer is currently running or not
    let isRunning: Bool
    /// Total elapsed milliseconds to determine if we should be able to reset or not
    let elapsedMs: Int
    /// Callback to record a lap
    let onLap: () -> Void
    /// Cakkvacj to reset the timer
    let onReset: () -> Void

    var body: some View {
        Button(action: {
            if isRunning {
                onLap()
            } else {
                onReset()
            }
        }) {
            Text(isRunning ? "Lap" : "Reset")
                .font(.title2)
                .foregroundColor(Color(.lightGray))
                .frame(width: 80, height: 80)
        }
        .background(Color(.darkGray))
        .clipShape(Circle())
        .disabled(!isRunning && elapsedMs == 0)
    }
}

// MARK: - Preview
struct LapButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LapButton(isRunning: true, elapsedMs: 12000, onLap: {}, onReset: {})
                .previewDisplayName("Running")
            LapButton(isRunning: false, elapsedMs: 12000, onLap: {}, onReset: {})
                .previewDisplayName("Pause - Reset")
            LapButton(isRunning: false, elapsedMs: 0, onLap: {}, onReset: {})
                .previewDisplayName("Disabled")
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
