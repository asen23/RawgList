//
//  GameList.swift
//  RawgList
//
//  Created by IT-Mobile-Dev on 07/08/21.
//

import Foundation

struct GameList: Decodable {
    var results: [Game]
    var next: String
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
        case next = "next"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        results = (try? values.decode([Game].self, forKey: .results)) ?? []
        next = (try? values.decode(String.self, forKey: .next)) ?? ""
    }
}

struct Game: Decodable, Identifiable {
    var id: Int
    var released: String
    var name: String
    var background_image: String
    var rating: Double
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case released = "released"
        case name = "name"
        case background_image = "background_image"
        case rating = "rating"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = (try? values.decode(Int.self, forKey: .id)) ?? 0
        released = (try? values.decode(String.self, forKey: .released)) ?? "N/A"
        name = (try? values.decode(String.self, forKey: .name)) ?? "N/A"
        background_image = (try? values.decode(String.self, forKey: .background_image)) ?? ""
        rating = (try? values.decode(Double.self, forKey: .rating)) ?? 0.0
    }
    
    init(id: Int, released: String, name: String, background_image: String, rating: Double) {
        self.id = id
        self.released = released
        self.name = name
        self.background_image = background_image
        self.rating = rating
    }
}
