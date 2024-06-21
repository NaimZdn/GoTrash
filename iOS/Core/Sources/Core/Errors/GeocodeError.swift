//
//  GeocodeError.swift
//  GoTrash
//
//  Created by Zidouni Naïm on 19/06/2024.
//

public enum GeocoderError: Error {
    case geocodingFailed(message: String)
    case noPlacemark
}
