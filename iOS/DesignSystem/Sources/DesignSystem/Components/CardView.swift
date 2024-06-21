//
//  CardView .swift
//  GoTrash
//
//  Created by Zidouni Naïm on 16/06/2024.
//

import Core
import SwiftUI

public struct CardView: View {
    // MARK: - Properties
    
    let isSelected: Bool
    var trash: Trash
    
    public var body: some View {
        HStack {
            Image(systemName: Constant.Icon.icTrash)
                .font(.system(size: .large))
                .padding(.xSmall)
                .background(.gtYellow, in: Circle())
            
            VStack(alignment: .leading, spacing: .xxSmall) {
                Text("\(trash.id)")
                    .bold()
                    .foregroundStyle(.gtText)
                Text(trash.address ?? "Not found")
                    .font(.footnote)
                    .foregroundStyle(.gtText.opacity(0.7))
            }
            
            Spacer()
            
            Circle()
                .frame(width: .small, height: .small)
                .foregroundColor(trash.full ? .red : .green)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(isSelected ? .gtYellow.opacity(0.3) : .gtCardBackground, in: RoundedRectangle(cornerRadius: .medium, style: .continuous))
    }
    
    // MARK: - Init
    
    public init(isSelected: Bool, trash: Trash) {
        self.isSelected = isSelected
        self.trash = trash
    }
}

//#Preview {
//    CardView(isSelected: true, 
//             trash: Trash(id: 1234,
//                          name: "Manor",
//                          location: Location(latitude: 1.1234,
//                                             longitude: 4.23123),
//                          full: true))
//}
