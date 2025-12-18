//
//  PersistenceController.swift
//  HabitTracker
//
//  Created by Marcelo Casanovas on 18/12/25.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    // Para previews
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let context = result.container.viewContext

        // Datos de ejemplo
        for i in 0..<3 {
            let h = Habit(context: context)
            h.title = "Hábito \(i + 1)"
            h.isCompleted = (i % 2 == 0)
            h.createdAt = Date().addingTimeInterval(TimeInterval(-i * 3600))
        }

        do { try context.save() }
        catch { fatalError("Preview save error: \(error)") }

        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        // 👇 ESTE NOMBRE debe ser EXACTAMENTE el nombre de tu .xcdatamodeld
        container = NSPersistentContainer(name: "HabitModel")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved Core Data error: \(error), \(error.userInfo)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
