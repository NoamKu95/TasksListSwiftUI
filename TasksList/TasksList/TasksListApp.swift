//
//  TasksListApp.swift
//  TasksList
//
//  Created by Noam Kurtzer on 17/03/2023.
//

import SwiftUI

@main
struct TasksListApp: App {
    let persistenceController = PersistenceController.shared
    @AppStorage(IS_DARK_MODE) var isDarkMode: Bool = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
