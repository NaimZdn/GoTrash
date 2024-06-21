//
//  TrashView.swift
//  GoTrash
//
//  Created by Zidouni Naïm on 16/06/2024.
//

import DesignSystem
import SwiftUI

struct TrashView: View {
    // MARK: - PRivate Properties
    
    @StateObject private var viewModel = TrashViewModel()
    @State private var isSelected = false
    
    // MARK: - Properties
    
    @Binding var selectedId: Int?
    
    var body: some View {
        ScrollView {
            VStack(spacing: .medium) {
                TextField("Search trash", text: .constant(""))
                    .padding(.vertical, .xSmall)
                    .padding(.horizontal)
                    .background {
                        RoundedRectangle(cornerRadius: .xSmall, 
                                         style: .continuous)
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
                        CardView(isSelected: viewModel.isSelected(trash: trash) || (selectedId == trash.id),
                                 trash: trash)
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
                        .background(.gtYellow, in: RoundedRectangle(cornerRadius: .xSmall,
                                                                          style: .continuous))
                }
            }
            .padding()
            .padding(.top)
        }
        .background(Color.gtBackground)
    }
}

// MARK: - Preview TrashView

#Preview {
    TrashView(selectedId: .constant(123))
}
