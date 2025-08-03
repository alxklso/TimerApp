import Foundation

/// A single lap entry for the stopwatch
///
/// Conforms to Identifiable so it can be used directly in SwiftUI lists.
struct Lap: Identifiable, Equatable {
    /// The lap number (1-based)
    let number: Int
    /// The formatted time string for this lap (e.g. "00:01.23")
    let time: String

    /// Uses `number` as the unique identifier for SwiftUI
    var id: Int { number }
}
