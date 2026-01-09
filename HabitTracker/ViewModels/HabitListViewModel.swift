import Foundation
import CoreData

@MainActor
final class HabitListViewModel: ObservableObject {

    func addHabit(title: String, context: NSManagedObjectContext) {
        let clean = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !clean.isEmpty else { return }

        let habit = Habit(context: context)
        habit.title = clean
        habit.isCompleted = false
        habit.createdAt = Date()

        save(context)
    }

    func toggle(_ habit: Habit, context: NSManagedObjectContext) {
        habit.isCompleted.toggle()
        save(context)
    }

    func delete(_ habit: Habit, context: NSManagedObjectContext) {
        context.delete(habit)
        save(context)
    }

    private func save(_ context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print("❌ Core Data save error:", error.localizedDescription)
        }
    }
    
    func pendingCount(context: NSManagedObjectContext) -> Int {
        let request: NSFetchRequest<Habit> = Habit.fetchRequest()
        
        request.predicate = NSPredicate(format: "isCompleted == NO")
        request.includesSubentities = false
        
        do{
            return try context.count(for: request)
        }catch{
            print("Pending count error", error.localizedDescription)
            return 0
        }
    }
}

