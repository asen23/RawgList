//
//  DetailViewModel.swift
//  RawgList
//
//  Created by IT-Mobile-Dev on 16/08/21.
//

import Foundation
import UIKit

class DetailViewModel: ObservableObject {
    private var id: Int
    @Published var games = GameDetail(
        id: 0,
        background_image: "",
        name: "N/A",
        genres: [],
        rating: 0.0,
        released: "N/A",
        description: "N/A",
        tags: [],
        developers: [],
        platforms: []
    )
    
    init(id: Int) {
        self.id = id
    }
    
    func getData() {
        NetworkManager.shared.getGameDetail(id: id) { data in
            var data = data
            let attributed = try? NSAttributedString(
                data: data.description.data(using: .utf8)!,
                options: [.documentType: NSAttributedString.DocumentType.html],
                documentAttributes: nil
            )
            data.description = attributed?.string ?? data.description
            DispatchQueue.main.async {
                self.games = data
            }
        }
    }
}
