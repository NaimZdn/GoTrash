//
//  Spacing.swift
//
//
//  Created by Zidouni Naïm on 21/06/2024.
//

import Foundation

public enum Spacing: CGFloat {
    case none = 0
    case xxxSmall = 2
    case xxSmall = 4
    case xSmall = 8
    case small = 12
    case medium = 16
    case xMedium = 20
    case large = 24
    case xLarge = 32
    case xxLarge = 56
    case xxxLarge = 64
}

// MARK: - Static Properties

public extension CGFloat {
    /// PictsManager 0 pts spacing.
    static let none = Spacing.none.rawValue
    /// PictsManager 2 pts spacing.
    static let xxxSmall = Spacing.xxxSmall.rawValue
    /// PictsManager 4 pts spacing.
    static let xxSmall = Spacing.xxSmall.rawValue
    /// PictsManager 8 pts spacing.
    static let xSmall = Spacing.xSmall.rawValue
    /// PictsManager 12 pts spacing.
    static let small = Spacing.small.rawValue
    /// PictsManager 16 pts spacing.
    static let medium = Spacing.medium.rawValue
    /// PictsManager 20 pts spacing.
    static let xMedium = Spacing.xMedium.rawValue
    /// PictsManager 24 pts spacing.
    static let large = Spacing.large.rawValue
    /// PictsManager 32 pts spacing.
    static let xLarge = Spacing.xLarge.rawValue
    /// PictsManager 48 pts spacing.
    static let xxLarge = Spacing.xxLarge.rawValue
    /// PictsManager 64 pts spacing.
    static let xxxLarge = Spacing.xxxLarge.rawValue
}

