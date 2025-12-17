//
//  HabitListView.swift
//  HabitTracker
//
//  Created by Marcelo Casanovas on 14/12/25.
//


import SwiftUI
import SwiftData

struct HabitListView: View {

    // Lee automáticamente desde la BD (SwiftData)
    // Ordena por fecha de creación, más recientes primero
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Habit.createdAt, order: .reverse)
    private var habits: [Habit]
    @State private var newHabitTitle: String = ""
    var body: some View {
        NavigationStack {
            Group {
                if habits.isEmpty {
                    ContentUnavailableView(
                        "Sin hábitos aún",
                        systemImage: "checklist",
                        description: Text("Ingresa un Habito")
                    )
                } else {
                    List {
                        ForEach(habits, id: \.persistentModelID) { habit in
                            HStack {
                                Image(systemName: habit.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .font(.title3)

                                Text(habit.title)
                                    .strikethrough(habit.isCompleted)
                                    .opacity(habit.isCompleted ? 0.5 : 1)

                                Spacer()
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Habit Tracker")
        }
    }
    
    private func addHabit() {
        let cleanTitle = newHabitTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !cleanTitle.isEmpty else { return }
        
        let habit = Habit(title: cleanTitle)
        modelContext.insert(habit)
        
        newHabitTitle = ""
    }
}

#Preview {
    HabitListView()
        .modelContainer(for: Habit.self, inMemory: true)
}
