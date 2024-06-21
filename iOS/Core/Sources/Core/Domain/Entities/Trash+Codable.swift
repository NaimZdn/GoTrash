//
//  Trash+Codable.swift
//  GoTrash
//
//  Created by Zidouni Naïm on 18/06/2024.
//

public struct Trash: Codable, Identifiable {
    public let id: Int
    public let name: String
    public let location: Location
    public let full: Bool
    public var address: String?
}
