//
//  TodoApp.swift
//  Todo
//
//  Created by Fei Yun on 2021-06-10.
//

import SwiftUI

@main
struct TodoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
