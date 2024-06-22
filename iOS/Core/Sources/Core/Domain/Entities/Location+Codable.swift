//
//  Location+Codable.swift
//  GoTrash
//
//  Created by Zidouni Naïm on 18/06/2024.
//

public struct Location: Decodable {
    public let latitude: Double
    public let longitude: Double
    
    // MARK: - Init
    
    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
