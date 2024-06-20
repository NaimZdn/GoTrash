//
//  MapViewModel.swift
//  GoTrash
//
//  Created by Zidouni Naïm on 18/06/2024.
//

import Factory
import Combine

final class MapViewModel: ObservableObject {
    // MARK: - Properties
    
    @Published private(set) var trashs: [Trash] = []
    
    // MARK: - Private Properties
    
    private var cancellables: Set<AnyCancellable> = []
    @Injected(\.observeTrashcansUseCase) private var observeTrashcansUseCase
    
    // MARK: - Init
    
    init() {
        observeTrashcans()
    }
}

// MARK: - Private Methods

private extension MapViewModel {
    func observeTrashcans() {
        observeTrashcansUseCase.observeTrashcans()
            .sink { [weak self] trashs in
                self?.trashs = trashs
            }
            .store(in: &cancellables)
    }
}
