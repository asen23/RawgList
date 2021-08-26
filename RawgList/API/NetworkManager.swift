//
//  NetworkManager.swift
//  RawgList
//
//  Created by IT-Mobile-Dev on 06/08/21.
//

import Foundation

class NetworkManager {
    public static var shared = NetworkManager()
    private var baseURL = "https://api.rawg.io/api/"
    private var apiKey: String {
      get {
        guard let filePath = Bundle.main.path(forResource: "Rawg-Info", ofType: "plist") else {
          fatalError("Couldn't find file 'Rawg-Info.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let key = plist?.object(forKey: "API_KEY") as? String else {
          fatalError("Couldn't find key 'API_KEY' in 'Rawg-Info.plist'.")
        }
        return key
      }
    }
    private let decoder = JSONDecoder()
    private var nextPage = ""
    
    public func getGameList(search: String, _ closure: @escaping (GameList) -> Void ) {
        var component = URLComponents(string: baseURL + "games")!
        
        component.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "search", value: search)
        ]
        
        let request = URLRequest(url: component.url!)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse, let data = data else { return }
            if response.statusCode == 200 {
                let data = try? self.decoder.decode(GameList.self, from: data)
                self.nextPage = data?.next ?? ""
                if let data = data {
                    closure(data)
                }
            } else {
                print("ERROR: \(data), HTTP Status: \(response.statusCode)")
            }
        }
        
        task.resume()
    }
    
    public func getGameDetail(id: Int, _ closure: @escaping (GameDetail) -> Void ) {
        var component = URLComponents(string: baseURL + "games/\(id)")!
        
        component.queryItems = [
            URLQueryItem(name: "key", value: apiKey)
        ]
        
        let request = URLRequest(url: component.url!)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse, let data = data else { return }
            if response.statusCode == 200 {
                let data = try? self.decoder.decode(GameDetail.self, from: data)
                if let data = data {
                    closure(data)
                }
            } else {
                print("ERROR: \(data), HTTP Status: \(response.statusCode)")
            }
        }
        
        task.resume()
    }
    
    public func getNextGameList(_ closure: @escaping (GameList) -> Void ) {
        if nextPage == "" {
            return
        }
        
        let request = URLRequest(url: URL(string: nextPage)!)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse, let data = data else { return }
            if response.statusCode == 200 {
                let data = try? self.decoder.decode(GameList.self, from: data)
                self.nextPage = data?.next ?? ""
                if let data = data {
                    closure(data)
                }
            } else {
                print("ERROR: \(data), HTTP Status: \(response.statusCode)")
            }
        }
        
        task.resume()
    }
}
