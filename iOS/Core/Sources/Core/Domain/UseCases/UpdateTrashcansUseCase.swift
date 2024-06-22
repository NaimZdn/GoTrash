//
//  UpdateTrashcansUseCase.swift
//
//
//  Created by Zidouni Naïm on 21/06/2024.
//

import Factory

public protocol UpdateTrashCanIsOpenUseCaseProtocol {
    func updateTrashcanIsOpen(trashId: Int, isOpen: Bool)
}

final class UpdateTrashCanIsOpenUseCase: UpdateTrashCanIsOpenUseCaseProtocol {
    // MARK: - Properties
    
    @Injected(\.firebaseService) private var firebaseService
    
    // MARK: - Methods
    
    func updateTrashcanIsOpen(trashId: Int, isOpen: Bool) {
        firebaseService.updateTrashcanIsOpen(trashId: trashId, isOpen: isOpen)
    }
}
