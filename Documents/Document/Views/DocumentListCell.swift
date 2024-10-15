//
//  DocumentListCell.swift
//  Documents
//
//  Created by Tom Scott on 9/25/23.
//  Updated by Tom Scott on 10/9/23 

import SwiftUI

struct DocumentListCell: View {
    @Environment(\.modelContext) var context
    let dateFormatter = DateFormatter()
    var document: Document
    
    init(document: Document) {
        self.document = document
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
    }
    
    var body: some View {
        VStack {
            HStack { Text(document.title ?? "missing title").font(.system(size: 14))
                Spacer() }
            HStack { Text("Size: \(document.size ?? 0) bytes").font(.system(size: 10))
                Spacer() }
            HStack { Text("Created: " + dateFormatter.string(from: document.createdOn ?? Date())).font(.system(size: 10))
                Spacer() }
            HStack { Text("Modified: " + dateFormatter.string(from: document.modifiedOn ?? Date())).font(.system(size: 10))
                Spacer() }
        }
    }
}

#Preview {
    DocumentListCell(document: Document())
        .modelContainer(for: Document.self)
}
