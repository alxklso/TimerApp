import Foundation

/// Utility for formatting elapsed milliseconds into time strings
struct TimeFormatter {
    /// Converts total milliseconds into a formatted string (HH:MM:SS.cc or MM:SS.cc)
    /// - Parameter totalMilliseconds: Elapsed time in milliseconds
    /// - Returns: A string like "01:23.45" (minutes:seconds.centiseconds) or "01:02:03.45" (hours:minutes:seconds.centiseconds)
    static func string(from totalMilliseconds: Int) -> String {
        // Compute two-digit centiseconds (0–99)
        let centis = (totalMilliseconds % 1_000) / 10
        let totalSeconds = totalMilliseconds / 1_000
        let seconds = totalSeconds % 60
        let minutes = (totalSeconds / 60) % 60
        let hours = totalSeconds / 3_600

        if hours > 0 {
            // Format: HH:MM:SS.cc
            return String(format: "%02d:%02d:%02d.%02d",
                          hours, minutes, seconds, centis)
        } else {
            // Format: MM:SS.cc
            return String(format: "%02d:%02d.%02d",
                          minutes, seconds, centis)
        }
    }
}
