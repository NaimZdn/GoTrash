//
//  Constant.swift
//
//
//  Created by Zidouni Naïm on 21/06/2024.
//

import MapKit

public enum Constant {
    static let databaseChild = "trashcans"
    static let emptyString = ""
    
    // MARK: - Icon
    
    public enum Icon {
        public static let icTrash = "trash.fill"
        public static let icGlass = "magnifyingglass"
    }
    
    // MARK: - Location
    
    enum Map {
        static let defaultSpan = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
    }
}
