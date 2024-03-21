//
//  PopupViewModifier.swift
//  PopupMenu
//
//  Created by window1 on 3/21/24.
//

import Foundation
import SwiftUI

struct PopupViewModifier: ViewModifier {
    
    @ObservedObject var sheetManager: SheetManager
    
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .bottom){
                if case let .present(config) = sheetManager.action {
                    PopupView(config: config) {
                        withAnimation(.spring) {
                            sheetManager.dismiss()
                        }
                    }
                }
            }
            .ignoresSafeArea()
    }
}

extension View {
    func popup(with sheetManager: SheetManager) -> some View {
        self.modifier(PopupViewModifier(sheetManager: sheetManager))
    }
}
