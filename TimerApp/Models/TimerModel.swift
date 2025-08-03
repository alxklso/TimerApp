import Foundation
import Combine

/// View-model driving the stopwatch logic
final class TimerModel: ObservableObject {
    // MARK: - Published State
    @Published private(set) var elapsedMs: Int = 0
    @Published private(set) var laps: [Lap] = []
    @Published var isRunning: Bool = false

    // MARK: - Internal Timer
    private var timerCancellable: AnyCancellable?

    // MARK: - Control Methods
    /// Starts the timer if not already running
    func start() {
        guard !isRunning else { return }
        isRunning = true
        timerCancellable = Timer
            .publish(every: 0.001, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.tick()
            }
    }

    /// Stops the timer
    func stop() {
        isRunning = false
        timerCancellable?.cancel()
        timerCancellable = nil
    }

    /// Resets elapsed time and clears all laps
    func reset() {
        stop()
        elapsedMs = 0
        laps.removeAll()
    }

    /// Records a new lap at the current elapsed time
    func lap() {
        guard isRunning else { return }
        let timeString = TimeFormatter.string(from: elapsedMs)
        let lapNumber = laps.count + 1
        laps.insert(Lap(number: lapNumber, time: timeString), at: 0)
    }

    // MARK: - Tick Handler
    /// Increments the elapsed time by 1 millisecond
    private func tick() {
        elapsedMs += 1
    }
}
