//
//  SearchTextField.swift
//  RawgList
//
//  Created by IT-Mobile-Dev on 25/08/21.
//

import SwiftUI

struct SearchTextField: View {
    @Binding var query: String
    let onCommit: () -> ()
    var body: some View {
        HStack {
            TextField(
                "Search...",
                text: $query,
                onCommit: onCommit
            )
            .padding(.leading, 8)
            .padding(.vertical, 8)
            Image(systemName: "magnifyingglass")
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .frame(height: 16)
                .padding(.horizontal, 8)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.black, lineWidth: 1)
        )
        .padding(.horizontal, 8)
    }
}

struct SearchTextField_Previews: PreviewProvider {
    static var previews: some View {
        SearchTextField(query: .constant(""), onCommit: {})
    }
}
