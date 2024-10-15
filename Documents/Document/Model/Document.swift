//
//  Document.swift
//  DocumentsSwiftData
//
//  Created by Tom Scott on 9/25/23.
//  Updated by Tom Scott on 10/9/2023 
// * This SwiftData model replaces the previous CoreData model and Persistence Controller

import Foundation
import SwiftData


@Model final class Document {
    var body: String?
    var createdOn: Date?
    var modifiedOn: Date?
    var size: Int64? = 0
    var title: String?
    

    init (
        body: String? = "",
        createdOn: Date? = .now,
        modifiedOn: Date? = .now,
        size: Int64? = 0,
        title: String? = nil
    ){
        self.body = body
        self.modifiedOn = modifiedOn
        self.size = size
        self.title = title
    }
    
}
