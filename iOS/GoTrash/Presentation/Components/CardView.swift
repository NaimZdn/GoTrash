//
//  CardView .swift
//  GoTrash
//
//  Created by Zidouni Naïm on 16/06/2024.
//

import SwiftUI

struct CardView: View {    
    // MARK: - Properties
    
    let isSelected: Bool
    var trash: Trash
    
    var body: some View {
        HStack {
            Image(systemName: "trash.fill")
                .font(.system(size: 24))
                .padding(8)
                .background(Color.gtPrimary, in: Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text("\(trash.id)")
                    .bold()
                Text(trash.address ?? "Not found")
                    .font(.footnote)
            }
            Spacer()
            
            Circle()
                .frame(width: 12, height: 12)
                .foregroundColor(trash.full ? .red : .green)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(isSelected ? Color.gtPrimary.opacity(0.3) : Color.white, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

#Preview {
    CardView(isSelected: true, 
             trash: Trash(id: 1234,
                          name: "Manor",
                          location: Location(latitude: 1.1234,
                                             longitude: 4.23123),
                          full: true))
}
