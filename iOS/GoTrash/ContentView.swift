//
//  ContentView.swift
//  GoTrash
//
//  Created by Zidouni Naïm on 16/06/2024.
//

import MapKit
import SwiftUI
import CoreLocation

struct ContentView: View {
    @State private var showSettings = true
    @StateObject private var viewModel = TrashViewModel()
    @State private var selectedItem: Int?
    
    let locationManager = CLLocationManager()
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    var body: some View {
        ZStack {
            Map(initialPosition: startPosition, selection: $selectedItem) {
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
            .onAppear {
                locationManager.requestWhenInUseAuthorization()
            }
        }
        .tint(Color.gtPrimary)
    }
}

#Preview {
    ContentView()
}

