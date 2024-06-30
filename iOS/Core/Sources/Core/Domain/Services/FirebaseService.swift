//
//  FirebaseService.swift
//  GoTrash
//
//  Created by Zidouni Naïm on 18/06/2024.
//

import OSLog
import Firebase
import FirebaseDatabaseInternal
import Combine

public protocol FirebaseServiceProtocol {
    func observeTrashCans() -> AnyPublisher<[Trash], Never>
    func updateTrashcanIsOpen(trashId: Int, isOpen: Bool)
}

final class FirebaseService: FirebaseServiceProtocol {
    // MARK: - Properties
    
    private var databaseReference: DatabaseReference
    private var observeTrashcansSubject = PassthroughSubject<[Trash], Never>()
    
    // MARK: - Init
    
    init() {
        FirebaseApp.configure()
        databaseReference = Database.database().reference()
    }
    
    // MARK: - Methods
    
    func observeTrashCans() -> AnyPublisher<[Trash], Never> {
        databaseReference.child(Constant.databaseChild).observe(.value) { parentSnapshot in
            guard let value = parentSnapshot.value as? [String: Any] else { return }
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: value)
                let trashcansResponse = try JSONDecoder().decode([String: Trash].self, from: jsonData)
                let trashcans = Array(trashcansResponse.values)
                self.observeTrashcansSubject.send(trashcans)
            } catch {
                Logger.core.fault("Failed to decode trashcans: \(error)")
            }
        }
        return self.observeTrashcansSubject.eraseToAnyPublisher()
    }
    
    func updateTrashcanIsOpen(trashId: Int, isOpen: Bool) {        
        let updates: [String: Any] = ["isOpen": isOpen]
        databaseReference.child("\(Constant.databaseChild)/\(trashId)").updateChildValues(updates) { error, _ in
            if let error = error {
                Logger.core.fault("Failed to update trash can: \(error)")
            } else {
                Logger.core.info("Successfully updated trash can isOpen status")
            }
        }
    }
}
