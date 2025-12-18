import SwiftUI
import CoreData

struct HabitListView: View {

    @Environment(\.managedObjectContext) private var context
    @StateObject private var viewModel = HabitListViewModel()

    @State private var newHabitTitle = ""
    @FocusState private var isTitleFocused: Bool

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Habit.createdAt, ascending: false)],
        animation: .default
    )
    private var habits: FetchedResults<Habit>

    var body: some View {
        NavigationView {
            VStack(spacing: 12) {

                HStack {
                    TextField("Nuevo hábito...", text: $newHabitTitle)
                        .textFieldStyle(.roundedBorder)
                        .focused($isTitleFocused)
                        .onSubmit(addHabit)

                    Button("Agregar", action: addHabit)
                        .buttonStyle(.borderedProminent)
                }
                .padding()

                if habits.isEmpty {
                    emptyState
                } else {
                    List {
                        ForEach(habits) { habit in
                            row(for: habit)
                        }
                        .onDelete(perform: delete)
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Habit Tracker")
            .toolbar { EditButton() }
        }
    }

    private var emptyState: some View {
        VStack(spacing: 8) {
            Image(systemName: "checklist")
                .font(.system(size: 44))
                .opacity(0.6)
            Text("Sin hábitos aún").font(.headline)
            Text("Agregá tu primer hábito arriba.")
                .font(.subheadline)
                .opacity(0.7)
        }
        .padding(.top, 40)
    }

    private func row(for habit: Habit) -> some View {
        HStack {
            Image(systemName: habit.isCompleted ? "checkmark.circle.fill" : "circle")
            Text(habit.title ?? "")
                .strikethrough(habit.isCompleted)
                .opacity(habit.isCompleted ? 0.5 : 1)
            Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            viewModel.toggle(habit, context: context)
        }
    }

    private func addHabit() {
        viewModel.addHabit(title: newHabitTitle, context: context)
        newHabitTitle = ""
        isTitleFocused = false
    }

    private func delete(at offsets: IndexSet) {
        offsets.map { habits[$0] }.forEach {
            viewModel.delete($0, context: context)
        }
    }
}

