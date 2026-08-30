//
//  blossommowieApp.swift
//  blossommowie
//
//  Created by Danya on 09.08.2026.
//

import SwiftUI
import SwiftData

@main
struct awesomemovie: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Title.self)
    }
}
