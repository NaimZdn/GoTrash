//
//  SwiftUIView.swift
//  
//
//  Created by Zidouni Naïm on 22/06/2024.
//

import SwiftUI

public struct GTButtonStyle: ButtonStyle {
    // MARK: - Properties
    
    let style: GTButtonStyleType
    
    // MARK: - Methods
    
    public func makeBody(configuration: Configuration) -> some View {
        GTButton(configuration: configuration, style: style)
    }
    
    // MARK: - Init
    
    public init(style: GTButtonStyleType) {
        self.style = style
    }
}

// MARK: - PMButton

private extension GTButtonStyle {
    struct GTButton: View {
        // MARK: Properties
        
        let configuration: ButtonStyle.Configuration
        let style: GTButtonStyleType
        
        var body: some View {
            configuration.label
                .frame(maxWidth: .infinity, minHeight: .xxLarge)
                .foregroundStyle(configuration.isPressed ? style.textColor.opacity(0.5) : style.textColor)
                .background(configuration.isPressed ? style.backgroundColor.opacity(0.5) : style.backgroundColor,
                            in: RoundedRectangle(cornerRadius: .xSmall))
        }
    }
}

// MARK: - ButtonStyle extension

public extension ButtonStyle where Self == GTButtonStyle {
    // MARK: - Methods
    
    static func gtDefault(_ color: Color) -> Self {
        return .init(style: .default(color))
    }
}

