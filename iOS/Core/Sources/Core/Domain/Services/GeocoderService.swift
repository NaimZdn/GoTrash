//
//  GeocoderService.swift
//  GoTrash
//
//  Created by Zidouni Naïm on 19/06/2024.
//

import CoreLocation
import Combine

public protocol GeocoderServiceProtocol {
    func reverseGeocodeLocation(_ location: CLLocation) -> AnyPublisher<String, GeocoderError>
}

final class GeocoderService: GeocoderServiceProtocol {
    // MARK: - Properties
    
    private let geocoder = CLGeocoder()
    
    // MARK: - Methods
    
    func reverseGeocodeLocation(_ location: CLLocation) -> AnyPublisher<String, GeocoderError> {
        Future<String, GeocoderError> { promise in            
            self.geocoder.reverseGeocodeLocation(location) { placemarks, error in
                if let error = error {
                    promise(.failure(.geocodingFailed(message: error.localizedDescription)))
                    return
                }
                
                if let placemark = placemarks?.first {
                    let address = self.parseAddress(placemark)
                    promise(.success(address))
                } else {
                    promise(.failure(.noPlacemark))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

// MARK: - Private Methods

private extension GeocoderService {
    func parseAddress(_ placemark: CLPlacemark) -> String {
        var addressString = ""
        
        if let subThoroughfare = placemark.subThoroughfare {
            addressString += "\(subThoroughfare) "
        }
        
        if let thoroughfare = placemark.thoroughfare {
            addressString += "\(thoroughfare), "
        }
        
        if let locality = placemark.locality {
            addressString += "\(locality)"
        }
        
        return addressString
    }
}
