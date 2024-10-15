//
//  NewDocumentView.swift
//  Documents
//
//  Created by Tom Scott on 9/25/23.
//  Updated by Tom Scott on 10/9/23 

import SwiftUI

struct NewDocumentView: View {
    @Environment(\.modelContext) var context
    @State var showingSaveDocumentErrorAlert = false
    @State var title: String = ""
    let completionHandler: (String, String) -> Void   // status, title
    
    init(completionHandler: @escaping  (String, String) -> Void) {
        self.completionHandler = completionHandler
    }
    
    var body: some View {
        NavigationView {
                Form {
                    Section() {
                        TextField("Font", text: $title)
                        HStack {
                            Spacer()
                            Button(action: {
                                if (title == "") {
                                    showingSaveDocumentErrorAlert = true
                                } else {
                                    completionHandler("ok", title)
                                }
                            }) { Text("Save") }
                            Spacer()
                        }
                    }.alert(isPresented: $showingSaveDocumentErrorAlert) {
                        Alert(title: Text("Missing Information"),
                              message: Text("A title must be provided for a new Document."),
                              dismissButton: .default(Text("OK")))
                    }
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
             .navigationBarTitle(Text("New Document"))
             .navigationBarItems(trailing: Button(action: {
                completionHandler("cancel", "")
             }, label: {
                 Text("Cancel")
             }))
        }
    }

}

#Preview {
    NewDocumentView() {status, title in
    }
}
