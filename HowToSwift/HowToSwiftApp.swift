//
//  HowToSwiftApp.swift
//  HowToSwift
//
//  Created by Moi Gutierrez on 2/22/21.
//

import SwiftUI

@main
struct HowToSwiftApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
