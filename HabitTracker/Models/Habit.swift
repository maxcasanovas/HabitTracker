//
//  Habit.swift
//  HabitTracker
//
//  Created by Marcelo Casanovas on 14/12/25.
//

import Foundation
import SwiftData

@Model
final class Habit {
    var title: String
    var isCompleted: Bool
    var createdAt: Date

    init(title: String, isCompleted: Bool = false, createdAt: Date = .now) {
        self.title = title
        self.isCompleted = isCompleted
        self.createdAt = createdAt
    }
}
