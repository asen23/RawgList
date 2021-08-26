//
//  GameDetail.swift
//  RawgList
//
//  Created by IT-Mobile-Dev on 16/08/21.
//

import Foundation

struct GameDetail: Codable {
    var id: Int
    var background_image: String
    var name: String
    var genres: [GameDetailList]
    var rating: Double
    var released: String
    var description: String
    var tags: [GameDetailList]
    var developers: [GameDetailList]
    var platforms: [GamePlatform]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case background_image = "background_image"
        case name = "name"
        case genres = "genres"
        case rating = "rating"
        case released = "released"
        case description = "description"
        case tags = "tags"
        case developers = "developers"
        case platforms = "platforms"
    }
    
    init(id: Int, background_image: String, name: String, genres: [GameDetailList], rating: Double, released: String, description: String, tags: [GameDetailList], developers: [GameDetailList], platforms: [GamePlatform]) {
        self.id = id
        self.background_image = background_image
        self.name = name
        self.genres = genres
        self.rating = rating
        self.released = released
        self.description = description
        self.tags = tags
        self.developers = developers
        self.platforms = platforms
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = (try? values.decode(Int.self, forKey: .id)) ?? 0
        background_image = (try? values.decode(String.self, forKey: .background_image)) ?? ""
        name = (try? values.decode(String.self, forKey: .name)) ?? "N/A"
        genres = (try? values.decode([GameDetailList].self, forKey: .genres)) ?? []
        rating = (try? values.decode(Double.self, forKey: .rating)) ?? 0.0
        released = (try? values.decode(String.self, forKey: .released)) ?? "N/A"
        description = (try? values.decode(String.self, forKey: .description)) ?? "N/A"
        tags = (try? values.decode([GameDetailList].self, forKey: .tags)) ?? []
        developers = (try? values.decode([GameDetailList].self, forKey: .developers)) ?? []
        platforms = (try? values.decode([GamePlatform].self, forKey: .platforms)) ?? []
    }
}

struct GameDetailList: Codable {
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = (try? values.decode(String.self, forKey: .name)) ?? "N/A"
    }
}

struct GamePlatform: Codable {
    var platform: GamePlatformDetail
    
    enum CodingKeys: String, CodingKey {
        case platform = "platform"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        platform = (try? values.decode(GamePlatformDetail.self, forKey: .platform)) ?? GamePlatformDetail(name: "N/A")
    }
}

struct GamePlatformDetail: Codable {
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = (try? values.decode(String.self, forKey: .name)) ?? "N/A"
    }
    
    init(name: String) {
        self.name = name
    }
}
