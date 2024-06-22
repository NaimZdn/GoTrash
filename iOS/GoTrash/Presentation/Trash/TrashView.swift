//
//  TrashView.swift
//  GoTrash
//
//  Created by Zidouni Naïm on 16/06/2024.
//

import Core
import DesignSystem
import SwiftUI

struct TrashView: View {
    // MARK: - PRivate Properties
    
    @StateObject private var viewModel = TrashViewModel()
    @State private var searchTrashTextField = ""
    @State private var isSelected = false
    @State private var lidState = false
    
    // MARK: - Properties
    
    @Binding var selectedId: Int?
    
    var body: some View {
        VStack {
            searchBar
                .padding(.top)
            
            ScrollView {
                VStack(spacing: .medium) {
                    
                    Spacer()
                    
                    if viewModel.trashs.isEmpty {
                        emptyView
                    } else {
                        cardView
                        
                        Button {
                            if let trashId = selectedId {
                                viewModel.updateTrashcanIsOpen(trashId: trashId, isOpen: lidState)
                                lidState.toggle()
                            }
                        } label: {
                            Text("Open trash")
                                .bold()
                        }
                        .buttonStyle(.gtDefault(selectedId == nil ? .gtYellow.opacity(0.4) : .gtYellow))
                        .disabled(selectedId == nil)
                    }
                }
            }
        }
        .padding()
        .tint(.gtPrimary)
        .background(Color.gtBackground)
    }
}

// MARK: - ViewBuilder

private extension TrashView {
    var searchBar: some View {
        HStack(spacing: .small) {
            Image(systemName: Constant.Icon.icGlass)
                .foregroundStyle(.placeholder)
            
            TextField("Search trash", text: $searchTrashTextField)
        }
        .padding(.vertical, .xSmall)
        .padding(.horizontal)
        .background {
            RoundedRectangle(cornerRadius: .xSmall,
                             style: .continuous)
            .fill(.gray.opacity(0.2))
        }
    }
    
    var emptyView: some View {
        VStack(spacing: .medium) {
            Image(systemName: Constant.Icon.icTrash)
                .font(.system(size: .xxxLarge))
                .padding()
                .background(.gtYellow, in: Circle())
            
            Text("There are no trash")
                .font(.system(size: .large))
                .bold()
        }
    }
    
    @ViewBuilder
    var cardView: some View {
        VStack(alignment: .leading) {
            Text("Trashcans")
                .font(.title2.bold())
            
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
                    GTTrashCard(isSelected: viewModel.isSelected(trash: trash) || (selectedId == trash.id),
                                trash: trash)
                    .foregroundStyle(.black)
                }
            }
        }
    }
}

// MARK: - Preview TrashView

#Preview {
    TrashView(selectedId: .constant(123))
}
