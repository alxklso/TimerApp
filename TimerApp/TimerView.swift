//
//  ContentView.swift
//  TimerApp
//
//  Created by AK on 8/2/25.
//

import SwiftUI

// @main marks the app's entry point
@main
struct TimerApp: App {
    // Body of my app describes the initial scene
    var body: some Scene {
        WindowGroup {
            // Shgow our custom TimerView when the app launches
            TimerView()
        }
    }
}

// View that displays the timer window and its controls
struct TimerView: View {
    // MARK: state properties
    // @Satet makes these variables "ground truth" for this view
    @State private var elapsedSeconds = 0        // Tracks how many seconds have passed
    @State private var isRunning = false        // Whether the timer is actively counting
    
    // MARK: Timer publisher
    // Creates a Combine publisher that emits once per second on the main run lop
    private let timer =
    Timer
        .publish(every: 1, on: .main, in: .common)
        .autoconnect() // Automatically starts the publisher
    
    var body: some View {
        VStack(spacing: 40) {
            // Displays the formatted time
            Text(formattedTime(elapsedSeconds))
                .font(.system(
                    size: 60,
                    weight: .bold,
                    design: .monospaced
                ))
            
            // Start / Pause / Reset Buttons
            HStack(spacing: 30) {
                
                // Start/Pause button
                Button(action: {
                    isRunning.toggle() // Flips between true/false
                }) {
                    Text(isRunning ? "Pause" : "Start")
                        .font(.title2)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(
                            Capsule().stroke(lineWidth: 2))
                }
                
                // RESET button
                Button("Reset") {
                    isRunning = false       // Stop the timer
                    elapsedSeconds = 0      // Reset counter to zero
                }
                .font(.title2)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(
                    Capsule().stroke(lineWidth: 2)
                )
            }
        }
        .padding()
        
        // MARK: React to timer events
        // .onReceive listens to the timer publisher
        
        .onReceive(timer) {_ in
            // Only increment when the timer is running
            if isRunning {
                elapsedSeconds += 1
            }
        }
    }
    
    
    // MARK: Helper function
    // Converts a total number of seconds into a human-readable string
    // - Parameter totalSeconds: Raw seconds count
    // - Returns: "HH:MM:SS" if >= 1 hour, else "MM:SS"
    private func formattedTime(_ totalSeconds: Int) -> String {
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        
        if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else {
            return String(format: "%02d:%02d", minutes, seconds)
        }
    }
    
}

#Preview {
    TimerView()
}
