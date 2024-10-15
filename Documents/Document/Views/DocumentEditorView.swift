//
//  DocumentEditorView.swift
//  Documents
//
//  Created by Tom Scott on 9/25/23.
//  Updated by Tom Scott on 10/9/2023 

import SwiftUI
import CoreData

struct DocumentEditorView: View {
    @State private var documentText: String = ""
    // Temporarily stores the text to be Undo'd or Redo'd
    @State private var undoText: [Character] = []
    @State private var title: String = ""
    let dateFormatter = DateFormatter()
    @Environment(\.modelContext) var context
    var document: Document
    
    init(document: Document) {
        self.document = document
        self._documentText = State(initialValue: document.body ?? "") // Used to load any previously saved text
        self._title = State(initialValue: document.title ?? "Untitled")
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
    }
    
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                Text("").bold()
                    .navigationTitle($title)
                    .navigationBarTitleDisplayMode(.inline)
                    .onChange(of: title, initial: true) {
                        saveDocument()
                    }
            }
            TextEditor(text: $documentText)
                .onChange(of: documentText, initial: true) {
                    saveDocument()
                }
                .toolbar {
                    ToolbarItemGroup (placement: .topBarTrailing) {
                        Button(action: undoType) {
                            Label("", systemImage: "arrow.uturn.backward")
                        }
                        Button(action: redoType) {
                            Label("", systemImage: "arrow.uturn.forward")
                        }
                        // Opens the default Share View
                        ShareLink(item: documentText)
                    }
                }
            Text("Last saved on " + dateFormatter.string(from: document.modifiedOn ?? Date())).font(.system(size: 10))
                Spacer()
        }.padding()
    }
    // Undo the last character update
    func undoType(){
        if let lastChar = documentText.last {
            undoText.append(lastChar)
            documentText = String(documentText.dropLast())
            saveDocument()
        }
    }
    // Redo the last character update
    func redoType(){
        if let lastChar = undoText.last {
            undoText.removeLast()
            documentText.append(lastChar)
            saveDocument()
        }
    }
    // Updates document body, size, and modification date after each change
    private func saveDocument() {
        document.title = self.title
        document.body = self.documentText
        document.size = Int64(document.body?.count ?? 0)
        document.modifiedOn = Date()
        try? context.save()
    }
}
