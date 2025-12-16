//
//  HabitListViewModel.swift
//  HabitTracker
//
//  Created by Marcelo Casanovas on 14/12/25.
//

import Foundation

final class HabitListViewModel: ObservableObject{
    
   @Published private(set) var habits: [Habit] = []
    
    func addHabit(title: String) {
        let cleanTitle = title.trimmingCharacters(in: .whitespaces)
        guard !cleanTitle.isEmpty else { return }
        
        let newHabit = Habit(title:cleanTitle)
        habits.append(newHabit)
        
    }
    
    func toggleCompletion(for habit: Habit) {
        guard let index = habits.firstIndex(of: habit) else { return }
        habits[index].isCompleted.toggle()
    }
    
    func deleteHabit(at offsets:IndexSet){
        habits.remove(atOffsets: offsets)
    }
}
