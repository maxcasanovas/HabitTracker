//
//  HabitListView.swift
//  HabitTracker
//
//  Created by Marcelo Casanovas on 14/12/25.
//


import SwiftUI



struct HabitListView: View {

    @StateObject private var viewModel = HabitListViewModel()
    @State private var newHabitTitle: String = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {

                HStack(spacing: 8) {
                    TextField("Nuevo hábito...", text: $newHabitTitle)
                        .textFieldStyle(.roundedBorder)

                    Button("Agregar") {
                        viewModel.addHabit(title: newHabitTitle)
                        newHabitTitle = ""
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding(.horizontal)
                .padding(.top, 8)

                List {
                    ForEach(viewModel.habits) { habit in
                        HStack {
                            Image(systemName: habit.isCompleted ? "checkmark.circle.fill" : "circle")
                                .font(.title3)

                            Text(habit.title)
                                .strikethrough(habit.isCompleted)
                                .opacity(habit.isCompleted ? 0.5 : 1)

                            Spacer()
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            viewModel.toggleCompletion(for: habit)
                        }
                    }
                    .onDelete(perform: viewModel.deleteHabit)
                }
                .listStyle(.insetGrouped)
            }
            .navigationTitle("Habit Tracker")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
            }
        }
    }
}

#Preview {
    HabitListView()
}
