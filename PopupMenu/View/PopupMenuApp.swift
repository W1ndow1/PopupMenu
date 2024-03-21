//
//  PopupMenuApp.swift
//  PopupMenu
//
//  Created by window1 on 2/29/24.
//

import SwiftUI

@main
struct PopupMenuApp: App {
    
    @StateObject var sheetManager = SheetManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(sheetManager)
        }
    }
}
