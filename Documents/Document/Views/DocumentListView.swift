//
//  DocumentListView.swift
//  DocumentsSwiftData
//
//  Created by Tom Scott on 9/25/23.
//  Updated by Tom Scott on 10/9/23 

import SwiftUI
import SwiftData

enum DocumentError: Error {
    case deleteError
}


struct DocumentListView: View {
    let dateFormatter = DateFormatter()
    // Object creation in SwiftData with modelContext
    @Environment(\.modelContext) var context
    // Dark/Light Mode toggle
    @AppStorage("isDarkMode") private var isDarkMode = false
    // Popovers
    @State private var showingNewDocumentPopover = false
    @State private var showingDeleteDocumentErrorAlert = false
    @State private var deleteDocumentErrorMessage = ""
    // Query all documents in SwiftData
    @Query private var documents: [Document]
    
    init() {
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(documents) { Document in
                    NavigationLink(destination: DocumentEditorView(document: Document)) {
                        DocumentListCell(document: Document)
                    }
                }.onDelete(perform: deleteDocuments)
            }.alert(isPresented: $showingDeleteDocumentErrorAlert) {
                Alert(title: Text("Error Deleting Document"),
                      message: Text("An error occurred deleting a Document: \(deleteDocumentErrorMessage)."),
                      dismissButton: .default(Text("OK")))
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Toggle("", systemImage: "moonphase.first.quarter", isOn: $isDarkMode)
                        .toggleStyle(.button)
                }
                ToolbarItem {
                    Button(action: {showingNewDocumentPopover = true}) {
                        Label("Add Item", systemImage: "plus")
                    }.popover(isPresented: $showingNewDocumentPopover) {
                        NewDocumentView() { status, title in
                            showingNewDocumentPopover = false
                            if (status == "ok") {
                                addDocument(title: title)
                            }
                        }
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
            }.navigationTitle("Documents")
        }
    }
        
    private func deleteDocuments(offsets: IndexSet) {
        withAnimation {
            // SwiftData Delete
            offsets.map { documents[$0] }.forEach(deleteDocument)
        }
    }
    
    private func deleteDocument(_ document: Document) {
        context.delete(document)
    }
    
    private func addDocument(title: String) {
        withAnimation {
            // Object creation in SwiftData
            let newDocument = Document()
            newDocument.title = title
            newDocument.createdOn = .now
            newDocument.modifiedOn = .now
            context.insert(newDocument)
            try? context.save()
        }
    }
}
    
// ModelContainer Preview
#Preview("Documents List") {
    let preview = PreviewContainer(([Document.self]))
    preview.add(items:[])
    return DocumentListView()
        .modelContainer(preview.container)
}
