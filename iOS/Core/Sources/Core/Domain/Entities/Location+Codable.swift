//
//  Location+Codable.swift
//  GoTrash
//
//  Created by Zidouni Naïm on 18/06/2024.
//

public struct Location: Decodable {
    // MARK: - Properties
    
    public let latitude: Double
    public let longitude: Double
    
    // MARK: - Static Properties
    
    static let paris = Location(latitude: 48.8566, longitude: 2.3522)
    
    // MARK: - Init
    
    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
