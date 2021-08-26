//
//  PersistenceManager.swift
//  RawgList
//
//  Created by IT-Mobile-Dev on 23/08/21.
//

import CoreData

class PersistenceManager: ObservableObject {
    private var context: NSManagedObjectContext
    @Published var game: [Game] = []
    
    init(_ context: NSManagedObjectContext) {
        self.context = context
    }
    
    private func save() {
        do {
            if context.hasChanges {
                try context.save()
            }
        } catch {
            print(error)
            context.rollback()
        }
    }
    
    func addFavorite(_ game: GameDetail) {
        let newFavorite = Favorite(context: context)
        newFavorite.id = Int64(game.id)
        newFavorite.name = game.name
        newFavorite.background_image = game.background_image
        newFavorite.released = game.released
        newFavorite.rating = game.rating
        
        save()
    }
    
    func isFavorite(_ id: Int) -> Bool{
        let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let favorite = try context.fetch(request).count == 1
            return favorite
        } catch {
            print(error)
        }
        
        return false
    }
    
    func deleteFavorite(_ id: Int) {
        let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let favorite = try context.fetch(request).first
            if let favorite = favorite {
                context.delete(favorite)
                
                save()
            }
        } catch {
            print(error)
        }
    }
    
    func loadFavorite(_ query: String) {
        let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        if !query.isEmpty {
            request.predicate = NSPredicate(format: "name CONTAINS[c] %@", query)
        }
        do {
            let favorites = try context.fetch(request)
            game = favorites.map {
                Game(
                    id: Int($0.id),
                    released: $0.released ?? "",
                    name: $0.name ?? "",
                    background_image: $0.background_image ?? "",
                    rating: $0.rating
                )
            }
        } catch {
            print(error)
        }
    }
    
    func addRating(_ id: Int, _ rating: Double) {
        let newRating = Rating(context: context)
        newRating.id = Int64(id)
        newRating.rating = rating
        
        save()
    }
    
    func getRating(_ id: Int) -> Double{
        let request: NSFetchRequest<Rating> = Rating.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let ratingObj = try context.fetch(request).first
            if let ratingObj = ratingObj {
                return ratingObj.rating
            }
        } catch {
            print(error)
        }
        
        return 0.0
    }
    
    func editRating(_ id: Int, _ rating: Double) {
        let request: NSFetchRequest<Rating> = Rating.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let favorite = try context.fetch(request).first
            if let favorite = favorite {
                favorite.rating = rating
                
                save()
            }
        } catch {
            print(error)
        }
    }
}
