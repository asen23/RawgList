//
//  ContentView.swift
//  RawgList
//
//  Created by IT-Mobile-Dev on 06/08/21.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = GameListViewModel()
    @State private var query = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                SearchTextField(query: $query) {
                    viewModel.search(query)
                }
                if viewModel.isLoading {
                    ProgressView()
                        .scaleEffect(4)
                        .frame(width: 300, height: 300)
                } else {
                    GameListView(
                        games: $viewModel.games,
                        getNextPage: viewModel.getNextPage,
                        isNextLoading: $viewModel.isNextLoading
                    )
                }
            }
            .navigationTitle("RawgList")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AboutView()) {
                        Image(systemName: "info.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: FavoriteView()) {
                        Image(systemName: "star.fill")
                    }
                }
            }
        }
        .onAppear {
            viewModel.search("")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
