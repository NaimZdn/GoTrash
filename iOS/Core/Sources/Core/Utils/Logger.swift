//
//  Logger.swift
//
//
//  Created by Zidouni Naïm on 29/06/2024.
//

import OSLog

public extension Logger {
    // MARK: - Private Properties
    
    private static var subsystem = Bundle.main.bundleIdentifier ?? Constant.emptyString
    
    // MARK: - Properties
    
    static let designSystem = Logger(subsystem: subsystem, category: "Design System")
    static let goTrash = Logger(subsystem: subsystem, category: "GoTrash")
    static let core = Logger(subsystem: subsystem, category: "Core")
}
