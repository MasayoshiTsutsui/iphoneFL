//
//  UseCoreMLApp.swift
//  UseCoreML
//
//  Created by Masayoshi Tsutsui on 2023/05/03.
//

import SwiftUI

@main
struct UseCoreMLApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
