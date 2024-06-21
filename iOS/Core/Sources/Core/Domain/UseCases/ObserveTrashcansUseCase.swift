//
//  ObserveTrashcansUseCase.swift
//  GoTrash
//
//  Created by Zidouni Naïm on 19/06/2024.
//

import Factory
import Combine

public protocol ObserveTrashcansUseCaseProtocol {
    func observeTrashcans() -> AnyPublisher<[Trash], Never>
}

final class ObserveTrashcansUseCase: ObserveTrashcansUseCaseProtocol {
    // MARK: - Properties
    
    @Injected(\.firebaseService) private var firebaseService
    
    // MARK: - Methods
    
    func observeTrashcans() -> AnyPublisher<[Trash], Never> {
        firebaseService.observeTrashCans()
    }
}
