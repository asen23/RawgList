//
//  RawgListApp.swift
//  RawgList
//
//  Created by IT-Mobile-Dev on 06/08/21.
//

import SwiftUI

@main
struct RawgListApp: App {
    let persistence = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(PersistenceManager(persistence.container.viewContext))
        }
    }
}
