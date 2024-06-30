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
    // MARK: - Private Properties
    
    @StateObject private var viewModel = TrashViewModel()
    @State private var searchTrashTextField = ""
    @State private var isSelected = false
    
    // MARK: - Properties
    
    @Binding var selectedId: Int?
    
    var body: some View {
        VStack {
            searchBarView
            
            ScrollView {
                VStack(spacing: .medium) {
                    
                    Spacer()
                    
                    if viewModel.trashs.isEmpty {
                        emptyView
                    } else {
                        cardView
                        toggleLidButtonView
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
    var searchBarView: some View {
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
        .padding(.top)
    }
    
    var emptyView: some View {
        VStack(spacing: .medium) {
            Image(systemName: Constant.Icon.icTrash)
                .foregroundStyle(.black)
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
            
            ForEach(viewModel.trashs.keys.sorted(), id: \.self) { key in
                if let trash = viewModel.trashs[key] {
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
                                    trash: trash
                        )
                        .foregroundStyle(.black)
                    }
                }
            }
        }
    }
    
    var toggleLidButtonView: some View {
        Button {
            if let trashId = selectedId {
                viewModel.updateTrashcanIsOpen(trashId: trashId)
            }
        } label: {
            Text(viewModel.toggleButtonText)
                .foregroundStyle(.black)
                .bold()
        }
        .buttonStyle(.gtDefault(selectedId == nil ? .gtYellow.opacity(0.4) : .gtYellow))
        .disabled(selectedId == nil)
    }
}

// MARK: - Preview TrashView

#Preview {
    TrashView(selectedId: .constant(123))
}
