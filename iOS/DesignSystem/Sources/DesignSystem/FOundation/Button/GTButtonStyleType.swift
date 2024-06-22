//
//  GTButtonStyleType.swift
//
//
//  Created by Zidouni Naïm on 22/06/2024.
//

import SwiftUI

public enum GTButtonStyleType {
    case `default`(Color)
    
    // MARK: - Properties
    
    var backgroundColor: Color {
        switch self {
        case .default(let color): return color
        }
    }
    
    var textColor: Color {
        switch self {
        case .default: return .gtText
        }
    }
}
