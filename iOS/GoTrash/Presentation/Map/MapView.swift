//
//  MapView.swift
//  GoTrash
//
//  Created by Zidouni Naïm on 16/06/2024.
//

import Core
import Factory
import DesignSystem
import MapKit
import SwiftUI
import CoreLocation

struct MapView: View {
    // MARK: - Private Properties
    
    @StateObject private var viewModel = MapViewModel()
    @State private var selectedItem: Int?
    
    @InjectedObject(\.locationManager) private var locationManager
    
    var body: some View {
        ZStack {
            Map(initialPosition: locationManager.startPosition, selection: $selectedItem) {
                ForEach(viewModel.trashs) { trash in
                    Marker(trash.name,
                           systemImage: Constant.Icon.icTrash,
                           coordinate: CLLocationCoordinate2D(latitude: trash.location.latitude,
                                                              longitude: trash.location.longitude))
                        .tint(Color.gtYellow)
                        .tag(trash.id)
                }
            }
            .tint(.gtPrimary)
            .padding(.top, .xLarge)
            .mapControls({
                MapUserLocationButton()
                MapScaleView()
            })
            .ignoresSafeArea()
            .bottomSheet {
                TrashView(selectedId: $selectedItem)
            }
        }
    }
}

// MARK: - Preview MapView

#Preview {
    MapView()
}

