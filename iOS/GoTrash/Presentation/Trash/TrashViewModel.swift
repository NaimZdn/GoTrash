//
//  TrashViewModel.swift
//  GoTrash
//
//  Created by Zidouni Naïm on 18/06/2024.
//

import Core
import Factory
import Foundation
import Combine
import Collections
import CoreLocation
import OSLog

final class TrashViewModel: ObservableObject {
    // MARK: - Proprerties
    
    @Published private(set) var trashs: [Int: Trash] = [:]
    @Published var selectedTrashId: Int? = nil
    
    var toggleButtonText: String {
        guard let selectedId = selectedTrashId, let trash = trashs[selectedId] else {
            return "Select trash"
        }
        return trash.isOpen ?? false ? "Close trash" : "Open trash"
    }
    
    // MARK: - Private Properties
    
    private var cancellables: Set<AnyCancellable> = []
    @Injected(\.observeTrashcansUseCase) private var observeTrashcansUseCase
    @Injected(\.reverseGeocodingUseCase) private var reverseGeocodingUseCase
    @Injected(\.updateTrashCanIsOpenUseCase) private var updateTrashCanIsOpenUseCase
    
    // MARK: - Init
    
    init() {
        observeTrashcans()
    }
    
    // MARK: - Methods
    
    func toggleSelection(for trash: Trash) {
        if selectedTrashId == trash.id {
            selectedTrashId = nil
        } else {
            selectedTrashId = trash.id
        }
    }
    
    func isSelected(trash: Trash) -> Bool {
        selectedTrashId == trash.id
    }
    
    func removeItem(for trash: Trash) {
        selectedTrashId = nil
    }
    
    func updateTrashcanIsOpen(trashId: Int) {
        guard let currentTrash = trashs[trashId] else { return }
        let isOpen = !(currentTrash.isOpen ?? false)
        updateTrashCanIsOpenUseCase.updateTrashcanIsOpen(trashId: trashId, isOpen: isOpen)
    }
}

// MARK: - Private Methods

private extension TrashViewModel {
    func observeTrashcans() {
        observeTrashcansUseCase.observeTrashcans()
            .sink { [weak self] trashs in
                self?.trashs = Dictionary(uniqueKeysWithValues: trashs.map { ($0.id, $0) })
                self?.updateAddresses(for: trashs)
            }
            .store(in: &cancellables)
    }
    
    func updateAddresses(for trashs: [Trash]) {
        for (index, trash) in trashs.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.1) { [weak self] in
                self?.updateAddress(for: trash, at: index)
            }
        }
    }
    
    func updateAddress(for trash: Trash, at index: Int) {
        guard index >= 0 && index < trashs.count else { return }
        
        let location = CLLocation(latitude: trash.location.latitude, longitude: trash.location.longitude)
        
        reverseGeocodingUseCase.reverseGeocodeLocation(location)
        .sink { completion in
            if case let .failure(error) = completion {
                Logger.goTrash.fault("Failed to geocode location: \(error)")
            }
        } receiveValue: { [weak self] address in
            guard let self = self else { return }
            
            var updatedTrash = trash
                       updatedTrash.address = address
                       self.trashs[trash.id] = updatedTrash
            
            print(updatedTrash)
            
            Logger.goTrash.info("Trash address was updated successfully")
        }
        .store(in: &cancellables)
    }

}
