//
//  GeocodeError.swift
//  GoTrash
//
//  Created by Zidouni Naïm on 19/06/2024.
//

enum GeocoderError: Error {
    case geocodingFailed(message: String)
    case noPlacemark
}
