//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Gamıd Khalıdov on 01.06.2024.
//
import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
