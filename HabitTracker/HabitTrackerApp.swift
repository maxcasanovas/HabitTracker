//
//  HabitTrackerApp.swift
//  HabitTracker
//
//  Created by Marcelo Casanovas on 14/12/25.
//

import SwiftUI
import SwiftData

@main
struct HabitTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            HabitListView()
        }
        .modelContainer(for: Habit.self)
    }
}
