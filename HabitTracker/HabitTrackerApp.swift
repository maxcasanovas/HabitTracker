import SwiftUI

@main
struct HabitTrackerApp: App {

    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HabitListView()
                .environment(\.managedObjectContext,
                              persistenceController.container.viewContext)
        }
    }
}

