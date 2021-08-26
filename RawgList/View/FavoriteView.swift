//
//  FavoriteView.swift
//  RawgList
//
//  Created by IT-Mobile-Dev on 25/08/21.
//

import SwiftUI

struct FavoriteView: View {
    @EnvironmentObject var manager: PersistenceManager
    @State var isLoading = false
    @State var query = ""
    var body: some View {
        ScrollView {
            SearchTextField(query: $query) {
                manager.loadFavorite(query)
            }
            if isLoading {
                ProgressView()
                    .scaleEffect(4)
                    .frame(width: 300, height: 300)
            } else {
                GameListView(
                    games: $manager.game,
                    getNextPage: { _ in },
                    isNextLoading: .constant(false)
                )
            }
        }
        .navigationTitle("Favorite")
        .onAppear {
            manager.loadFavorite(query)
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
