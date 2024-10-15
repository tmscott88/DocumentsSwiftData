//
//  PreviewContainer.swift
//  DocumentsSwiftData
//
//  Created by Tom Scott on 9/26/23
//  Updated by Tom Scott on 10/9/23

// * This serves as a modular container for XCode Previews.

import SwiftData
import SwiftUI

struct PreviewContainer {
    let container: ModelContainer!
    
    init(_ types: [any PersistentModel.Type],
         isStoredInMemoryOnly: Bool = false) {
        let schema = Schema(types)
        let config = ModelConfiguration(isStoredInMemoryOnly: isStoredInMemoryOnly)
        self.container = try? ModelContainer(for: schema, configurations: [config])
    }
    
    func add(items: [any PersistentModel]) {
        Task { @MainActor in
            items.forEach{container.mainContext.insert($0)}
        }
    }
}
