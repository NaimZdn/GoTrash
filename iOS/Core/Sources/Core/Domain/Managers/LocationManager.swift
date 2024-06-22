//
//  LocationManager.swift
//  GoTrash
//
//  Created by Zidouni Naïm on 18/06/2024.
//

import CoreLocation
import _MapKit_SwiftUI

public final class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    // MARK: - Properties
    
    public var startPosition: MapCameraPosition {
        if let userLocation = location {
            return MapCameraPosition.region(
                MKCoordinateRegion(
                    center: userLocation.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
                )
            )
        } else {
            return MapCameraPosition.region(
                MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522),
                    span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
                )
            )
        }
    }
    
    // MARK: - Private Properties
    
    private let locationManager = CLLocationManager()
    private var location: CLLocation?
    
    // MARK: - Init
    
    public override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

