//
//  MovieAppApp.swift
//  MovieApp
//
//  Created by OGBODO on 18/02/2026.
//

import SwiftUI
import SwiftData

@main
struct MovieAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        
        .modelContainer(for: Title.self)
    }
}
