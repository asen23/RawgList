//
//  GameListView.swift
//  RawgList
//
//  Created by IT-Mobile-Dev on 25/08/21.
//

import SwiftUI

struct GameListView: View {
    @Binding var games: [Game]
    let getNextPage: (Int) -> ()
    @Binding var isNextLoading: Bool
    
    var body: some View {
        if games.isEmpty {
            VStack(alignment: .center) {
                Text("No data")
                    .font(.title)
            }
        }
        LazyVStack {
            ForEach(games) { data in
                NavigationLink(destination: DetailView(id: data.id)) {
                    GameRowView(game: data)
                }
                .onAppear {
                    getNextPage(data.id)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.horizontal, 8)
        if isNextLoading {
            ProgressView()
                .scaleEffect(2)
                .frame(width: 100, height: 100)
        }
    }
}

struct GameListView_Previews: PreviewProvider {
    static var previews: some View {
        GameListView(games: .constant([]), getNextPage: { _ in }, isNextLoading: .constant(false))
    }
}
