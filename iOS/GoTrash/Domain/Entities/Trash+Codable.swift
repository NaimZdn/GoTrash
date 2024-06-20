//
//  Trash+Codable.swift
//  GoTrash
//
//  Created by Zidouni Naïm on 18/06/2024.
//

struct Trash: Codable, Identifiable {
    let id: Int
    let name: String
    let location: Location
    let full: Bool
    var address: String?
}
