//
//  DocumentsApp.swift
//  DocumentsSwiftData
//
//  Created by Tom Scott on 9/25/23.
//  Updated by Tom Scott on 10/9/23 

import SwiftUI
import SwiftData

@main
struct DocumentsApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = false
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(
                    for: [Document.self], isUndoEnabled: true)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
