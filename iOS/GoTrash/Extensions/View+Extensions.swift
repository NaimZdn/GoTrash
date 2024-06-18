//
//  View+Extensions.swift
//  GoTrash
//
//  Created by Zidouni Naïm on 16/06/2024.
//

import SwiftUI

extension View {
    func bottomSheet<SheetContent: View>(
        initialHeight: CGFloat = 64,
        sheetCornerRadius: CGFloat = 16,
        @ViewBuilder content: @escaping () -> SheetContent
    ) -> some View {
        self.modifier(ButtonSheetModifier(initialHeight: initialHeight, sheetCornerRadius: sheetCornerRadius, sheetView: content()))
    }
}
  

fileprivate struct ButtonSheetModifier<SheetContent: View>: ViewModifier {
    var initialHeight: CGFloat
    var sheetCornerRadius: CGFloat
    var sheetView: SheetContent
    
    @State private var isPresentedSheet: Bool = true
    
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
