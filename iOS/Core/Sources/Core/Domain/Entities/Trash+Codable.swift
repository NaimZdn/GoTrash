//
//  Trash+Codable.swift
//  GoTrash
//
//  Created by Zidouni Naïm on 18/06/2024.
//

public struct Trash: Decodable, Identifiable {
    public let id: Int
    public let name: String
    public let location: Location
    public let isFull: Bool
    public var address: String?
    public var isOpen: Bool?
    
    // MARK: - Init
    
    public init(id: Int, name: String, location: Location, isFull: Bool, address: String? = nil, isOpen: Bool? = nil) {
        self.id = id
        self.name = name
        self.location = location
        self.isFull = isFull
        self.address = address
        self.isOpen = isOpen
    }
}
