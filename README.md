# Documents SwiftData V2

## Overview
- Created by Tom Scott on 9/25/2023 for IT4425 @ University of Missouri
    - Updated by Tom Scott on 10/9/2023 
- Purpose: Improve existing Documents SwiftData project

## Key Changes
- Added a "Last modified" indicator to the Documents editor
- Added a Dark/Light mode toggle to the home view 
- (PARTIAL) Added undo/redo functionality to the Documents editor

## Known Issues
- (SOLVED) Modifying state during view update, undefined behavior: https://www.hackingwithswift.com/quick-start/swiftui/how-to-fix-modifying-state-during-view-update-this-will-cause-undefined-behavior
- Global theme does not apply to NewDocumentView on the first "popover" after changing the theme.
- Undo and Redo functions work with text added to the end of the document, though not if text is added within or before existing text. 
    - I found that SwiftData's UndoManager, while better designed, does not fit my implementation as well and requires a more complex UITextView configuration to work with the native UndoManager

## Resources
- App-wide Dark/Light modes: https://medium.com/@amitsrivastava115/toggle-between-dark-and-light-mode-in-swiftui-across-whole-app-5ccfc06a8eca
- ToggleStyle: https://developer.apple.com/documentation/swiftui/togglestyle
- Undo/Redo in SwiftData: https://www.hackingwithswift.com/quick-start/swiftdata/how-to-add-support-for-undo-and-redo
    - Older solution: https://developer.apple.com/forums/thread/683311
- Use ShareLink for sharing/exporting data: https://www.appcoda.com/learnswiftui/swiftui-sharelink.html
