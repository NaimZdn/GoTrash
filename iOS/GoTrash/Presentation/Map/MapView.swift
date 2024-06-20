//
//  MapView.swift
//  GoTrash
//
//  Created by Zidouni Naïm on 16/06/2024.
//

import MapKit
import SwiftUI
import CoreLocation

struct MapView: View {
    // MARK: - Private Properties
    
    @StateObject private var viewModel = MapViewModel()
    @StateObject private var locationManager = LocationManager()
    @State private var showSettings = true
    @State private var selectedItem: Int?
    
    var body: some View {
        ZStack {
            Map(initialPosition: locationManager.startPosition, selection: $selectedItem) {
                ForEach(viewModel.trashs) { trash in
                    Marker(trash.name, systemImage: "trash.fill", coordinate: CLLocationCoordinate2D(latitude: trash.location.latitude, longitude: trash.location.longitude))
                        .tint(Color.gtPrimary)
                        .tag(trash.id)
                }
            }
            .padding(.top, 32)
            .mapControls({
                MapUserLocationButton()
            })
            .ignoresSafeArea()
            .bottomSheet {
                TrashView(selectedId: $selectedItem)
            }
        }
        .tint(Color.gtPrimary)
    }
}

// MARK: - Preview MapView

#Preview {
    MapView()
}

