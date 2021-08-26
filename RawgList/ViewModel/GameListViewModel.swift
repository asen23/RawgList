//
//  HomeViewModel.swift
//  RawgList
//
//  Created by IT-Mobile-Dev on 07/08/21.
//

import Foundation
import SwiftUI

class GameListViewModel: ObservableObject {
    @Published var games = [Game]()
    @Published var isLoading = false
    @Published var isNextLoading = false
    
    func search(_ query: String){
        isLoading = true
        NetworkManager.shared.getGameList(search: query) { data in
            DispatchQueue.main.async {
                self.games = data.results
                self.isLoading = false
            }
        }
    }
    
    func getNextPage(id: Int) {
        let idx = games.firstIndex{ $0.id == id }
        if idx == games.count - 1 {
            isNextLoading = true
            NetworkManager.shared.getNextGameList() { data in
                DispatchQueue.main.async {
                    self.games.append(contentsOf: data.results)
                    self.isNextLoading = false
                }
            }
        }
    }
}
