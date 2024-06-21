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

final class TrashViewModel: ObservableObject {
    // MARK: - Proprerties
    
    @Published private(set) var trashs: [Trash] = []
    @Published var selectedTrashIds: Set<Int> = []
    
    // MARK: - Private Properties
    
    private var cancellables: Set<AnyCancellable> = []
    @Injected(\.observeTrashcansUseCase) private var observeTrashcansUseCase
    @Injected(\.reverseGeocodingUseCase) private var reverseGeocodingUseCase
    
    // MARK: - Init
    
    init() {
        observeTrashcans()
    }
    
    func toggleSelection(for trash: Trash) {
        if selectedTrashIds.contains(trash.id) {
            selectedTrashIds.remove(trash.id)
        } else {
            selectedTrashIds.insert(trash.id)
        }
    }
    
    func isSelected(trash: Trash) -> Bool {
        selectedTrashIds.contains(trash.id)
    }
    
    func removeItem(for trash: Trash) {
        selectedTrashIds.remove(trash.id)
    }
}

// MARK: - Private Methods

private extension TrashViewModel {
    func observeTrashcans() {
        observeTrashcansUseCase.observeTrashcans()
            .sink { [weak self] trashs in
                self?.trashs = trashs
                trashs.forEach { self?.updateAddress(for: $0) }
            }
            .store(in: &cancellables)
    }
    
    func updateAddress(for trash: Trash) {
        guard let index = trashs.firstIndex(where: { $0.id == trash.id }) else { return }
        
        reverseGeocodingUseCase.reverseGeocodeLocation(latitude: trash.location.latitude,
                                                      longitude: trash.location.longitude)
            .sink { _ in }
            receiveValue: { [weak self] address in
                self?.trashs[index].address = address
            }
            .store(in: &cancellables)
    }
}
