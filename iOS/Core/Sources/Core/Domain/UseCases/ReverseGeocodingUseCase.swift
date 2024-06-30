//
//  ReverseGeocodingUseCase.swift
//  GoTrash
//
//  Created by Zidouni Naïm on 20/06/2024.
//

import Factory
import Combine
import CoreLocation

public protocol ReverseGeocodeLocationUseCaseProtocol {
    func reverseGeocodeLocation(_ location: CLLocation) -> AnyPublisher<String, GeocoderError>
}

final class ReverseGeocodeLocationUseCase: ReverseGeocodeLocationUseCaseProtocol {
    // MARK: - Private Properties
    
    @Injected(\.geocoderService) private var geocoderService
    
    // MARK: - Methods
    
    func reverseGeocodeLocation(_ location: CLLocation) -> AnyPublisher<String, GeocoderError> {
        geocoderService.reverseGeocodeLocation(location)
    }
}
