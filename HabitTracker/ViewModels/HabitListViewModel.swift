//
//  HabitListViewModel.swift
//  HabitTracker
//
//  Created by Marcelo Casanovas on 14/12/25.
//

import Foundation
import SwiftData

@MainActor
final class HabitListViewModel: ObservableObject{
    
    func addHabit(title: String, context: ModelContext) {
            let cleanTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !cleanTitle.isEmpty else { return }

            let habit = Habit(title: cleanTitle)
            context.insert(habit)
        }

        func toggle(_ habit: Habit) {
            habit.isCompleted.toggle()
        }

        func deleteHabits(at offsets: IndexSet, habits: [Habit], context: ModelContext) {
            for index in offsets {
                context.delete(habits[index])
            }
        }
}
