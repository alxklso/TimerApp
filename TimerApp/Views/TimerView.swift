import SwiftUI

/// Main stopwatch view
struct TimerView: View {
    @StateObject private var model = TimerModel()

    var body: some View {
        VStack(spacing: 20) {
            // Display elapsed time
            Text(TimeFormatter.string(from: model.elapsedMs))
                .font(.system(size: 90, weight: .thin, design: .default))
                .monospacedDigit()

            // Control buttons
            HStack(spacing: 190) {
                // Lap button
                LapButton(isRunning: model.isRunning, elapsedMs: model.elapsedMs,
                          onLap: model.lap, onReset: model.reset)

                // Start / Stop button
                Button(action: {
                    if model.isRunning {
                        model.stop()
                    } else {
                        model.start()
                    }
                }) {
                    Text(model.isRunning ? "Stop" : "Start")
                        .font(.title2)
                        .foregroundColor(model.isRunning ? .red : .green)
                        .frame(width: 80, height: 80)
                        .background(model.isRunning
                                    ? Color(red: 0.5, green: 0.0, blue: 0.0)
                                    : Color(red: 0.0, green: 0.5, blue: 0.0))
                        .clipShape(Circle())
                }
            }

            // List of recorded laps
            LapListView(laps: model.laps)
        }
        .padding()
    }
}

// MARK: - Preview
struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
