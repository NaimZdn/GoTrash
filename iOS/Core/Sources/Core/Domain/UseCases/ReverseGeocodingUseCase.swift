//
//  ReverseGeocodingUseCase.swift
//  GoTrash
//
//  Created by Zidouni Naïm on 20/06/2024.
//

import Factory
import Combine

public protocol ReverseGeocodeLocationUseCaseProtocol {
    func reverseGeocodeLocation(latitude: Double, longitude: Double) -> AnyPublisher<String, GeocoderError>
}

final class ReverseGeocodeLocationUseCase: ReverseGeocodeLocationUseCaseProtocol {
    // MARK: - Private Properties
    
    @Injected(\.geocoderService) private var geocoderService
    
    // MARK: - Methods
    
    func reverseGeocodeLocation(latitude: Double, longitude: Double) -> AnyPublisher<String, GeocoderError> {
        geocoderService.reverseGeocodeLocation(latitude: latitude, longitude: longitude)
    }
}
