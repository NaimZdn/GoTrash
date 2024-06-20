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
