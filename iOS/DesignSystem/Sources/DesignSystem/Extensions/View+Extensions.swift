//
//  View+Extensions.swift
//  GoTrash
//
//  Created by Zidouni Naïm on 16/06/2024.
//

import SwiftUI

public extension View {
    // MARK: - Modifier
    
    func bottomSheet<SheetContent: View>(
        initialHeight: CGFloat = .xxxLarge,
        sheetCornerRadius: CGFloat = .medium,
        @ViewBuilder content: @escaping () -> SheetContent
    ) -> some View {
        self.modifier(ButtonSheetModifier(initialHeight: initialHeight, sheetCornerRadius: sheetCornerRadius, sheetView: content()))
    }
}
  
fileprivate struct ButtonSheetModifier<SheetContent: View>: ViewModifier {
    // MARK: - Properties
    
    var initialHeight: CGFloat
    var sheetCornerRadius: CGFloat
    var sheetView: SheetContent
    
    @State private var isPresentedSheet: Bool = true
    
    // MARK: - Methods
    
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresentedSheet, content: {
                sheetView
                    .presentationDetents([.height(initialHeight), .medium, .large])
                    .presentationCornerRadius(sheetCornerRadius)
                    .presentationBackgroundInteraction(.enabled(upThrough: .medium))
                    .interactiveDismissDisabled()
            })
    }
}
