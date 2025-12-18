import SwiftUI
import SwiftData

struct HabitListView: View {

    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = HabitListViewModel()

    @FocusState private var isTitleFocused: Bool
    @Query(sort: \Habit.createdAt, order: .reverse)
    private var habits: [Habit]

    @State private var newHabitTitle: String = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {

                HStack(spacing: 8) {
                    TextField("Nuevo hábito...", text: $newHabitTitle)
                        .textFieldStyle(.roundedBorder)
                        .focused($isTitleFocused)
                        .submitLabel(.done)
                        .onSubmit {
                            addHabitFromUI()
                        }

                    Button("Agregar") {
                        addHabitFromUI()
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding(.horizontal)
                .padding(.top, 8)

                Group {
                    if habits.isEmpty {
                        ContentUnavailableView(
                            "Sin hábitos aún",
                            systemImage: "checklist",
                            description: Text("Agregá tu primer hábito arriba.")
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
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    viewModel.toggle(habit)
                                    isTitleFocused = false
                                }
                            }
                            .onDelete { offsets in
                                viewModel.deleteHabits(at: offsets, habits: habits, context: modelContext)
                            }
                        }
                        .listStyle(.insetGrouped)
                    }
                }
            }
            .navigationTitle("Habit Tracker")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
            }
            .onTapGesture {
                isTitleFocused = false
            }
        }
    }

    private func addHabitFromUI() {
        viewModel.addHabit(title: newHabitTitle, context: modelContext)
        newHabitTitle = ""
        isTitleFocused = false
    }
}

#Preview {
    HabitListView()
        .modelContainer(for: Habit.self, inMemory: true)
}

