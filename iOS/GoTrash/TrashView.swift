//
//  TrashView.swift
//  GoTrash
//
//  Created by Zidouni Naïm on 16/06/2024.
//

import SwiftUI

struct TrashView: View {
    @StateObject private var viewModel = TrashViewModel()
    @State private var isSelected = false
    
    @Binding var selectedId: Int?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                TextField("Search trash", text: .constant(""))
                    .padding(.vertical, 8)
                    .padding(.horizontal)
                    .background {
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(.gray.opacity(0.2))
                    }
                
                Spacer()
                
                ForEach(viewModel.trashs) { trash in
                    Button {
                        if trash.id == selectedId {
                            selectedId = nil
                            viewModel.removeItem(for: trash)
                        } else {
                            viewModel.toggleSelection(for: trash)
                            selectedId = trash.id
                        }
                    } label: {
                        CardView(isSelected: viewModel.isSelected(trash: trash) || (selectedId == trash.id), trash: trash)
                            .foregroundStyle(.black)
                    }
                }
                
                Button {
                    // Open Trash
                } label: {
                    Text("Open trash")
                        .foregroundStyle(.black)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gtPrimary, in: RoundedRectangle(cornerRadius: 8,
                                                                          style: .continuous))
                }
            }
            .padding()
            .padding(.top)
            
        }
        .background(Color.gtBackground)
    }
}

//#Preview {
//    TrashView(selectedId: .constant(true))
//}

struct Trash: Identifiable {
    let id: Int
    let name: String
    let location: LocationModel
}

struct LocationModel {
    let latitude: Double
    let longitude: Double
}

final class TrashViewModel: ObservableObject {
    @Published private(set) var trashs: [Trash] = [
        Trash(id: 1134, name: "Manor", location: LocationModel(latitude: 48.815410, longitude: 2.365179)),
        Trash(id: 427412, name: "Park", location: LocationModel(latitude: 48.815510, longitude: 2.365279)),
        Trash(id: 422, name: "Street", location: LocationModel(latitude: 48.815610, longitude: 2.365179))
    ]
    
    @Published var selectedTrashIds: Set<Int> = []
    
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
    
    func filterTrashById(_ id: Int) -> Trash? {
        trashs.first { $0.id == id }
    }
    
    func removeItem(for trash: Trash) {
        selectedTrashIds.remove(trash.id)
    }
}
