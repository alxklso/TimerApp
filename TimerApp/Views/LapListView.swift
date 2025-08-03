import SwiftUI

/// A view that displays a scrolling list of lap entries
struct LapListView: View {
    /// Array of Lap models to display (newest first)
    let laps: [Lap]

    var body: some View {
        // If no laps, show placeholder text
        if laps.isEmpty {

        } else {
            // Display a plain list of laps
            List(laps) { lap in
                HStack {
                    Text("Lap \(lap.number)")
                        .bold()
                    Spacer()
                    Text(lap.time)
                        .monospacedDigit()
                }
                .padding(.vertical, 4)
            }
            .listStyle(PlainListStyle())
            // Limit height so it doesn't overwhelm the UI
            .frame(maxHeight: 200)
        }
    }
}

// MARK: - Preview
struct LapListView_Previews: PreviewProvider {
    static var previews: some View {
        LapListView(laps: [
            Lap(number: 3, time: "00:03.45"),
            Lap(number: 2, time: "00:02.34"),
            Lap(number: 1, time: "00:01.23")
        ])
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
