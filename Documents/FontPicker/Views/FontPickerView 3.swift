//
//  FontPickerView.swift
//  DocumentsSwiftDataV2
//
//  Created by Tom Scott on 10/11/23.
//  Adapted from Franklyn Weber's FontPicker package

import SwiftUI

struct FontPickerView: View {
    @Environment(\.modelContext) var context
    @State var showingChooseFontErrorAlert = false
    @State var font: String = ""
    
    internal var userFontNames: [String]?
    internal var additionalFontNames: [String] = []
    
    // These fonts render in an odd way, with tops or bottoms being chopped off, or being nonsense for our purposes (such as symbols)
    // However, if the user wants them, they just need to specify [] as the excludedFontNames
    internal var excludedFontNames = [
        "Bodoni Ornaments",
        "Damascus",
        "Hiragino"
    ]
    
    internal var backgroundColor: UIColor = .systemBackground
    
    let completionHandler: (String, String) -> Void   // status, font
    
    init(completionHandler: @escaping  (String, String) -> Void) {
        self.completionHandler = completionHandler
    }
    
    var body: some View {
        VStack {
           Text("Choose Font")
               .font(Font.headline.weight(.semibold))
               .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
               .lineLimit(1)
           ZStack {
               RoundedRectangle(cornerRadius: 10)
                   .foregroundColor(Color(backgroundColor.withAlphaComponent(0.4).equivalentColorWithNoTransparency))
               List {
                   ForEach(fontNamesToDisplay(), id: \.self) { fontName in
                       HStack {
                           Text(fontName)
                               .customFont(name: fontName)
                           Spacer()
                       }
                       .contentShape(Rectangle())
                       .onTapGesture {
                           font = fontName
                           if font == "" {
                               showingChooseFontErrorAlert = true
                           } else {
                               completionHandler("ok", font)
                           }
                       }
                   }
                   .listRowBackground(Color.clear)
               }
           }
       }
//        .contentInsets(EdgeInsets(top: 8, leading: 16, bottom: 16, trailing: 16))
//        .backgroundColor(backgroundColor)
//        .closeButtonColor(UIColor.black.withAlphaComponent(0.3))
    }
    private func fontNamesToDisplay() -> [String] {
        
        if let userFontNames = userFontNames {
            return userFontNames
        }
        
        let fontNames = UIFont.familyNames.sorted().filter { !excludedFontNames.contains(where: $0.contains) }
        
        return (fontNames + additionalFontNames).sorted()
    }
}

#Preview {
    FontPickerView() {status, font in
    }
}

