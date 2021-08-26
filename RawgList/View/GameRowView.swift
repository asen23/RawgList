//
//  HomeRowView.swift
//  RawgList
//
//  Created by IT-Mobile-Dev on 15/08/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct GameRowView: View {
    var game: Game
    
    var body: some View {
        HStack(spacing: 8) {
            WebImage(url: URL(string: game.background_image))
                .resizable()
                .placeholder(Image(systemName: "photo"))
                .indicator(.activity)
                .scaledToFill()
                .frame(width: 100, height: 100, alignment: .center)
                .clipped()
            VStack(alignment: .leading) {
                Text(game.name)
                Text(game.released)
                HStack {
                    Text("\(game.rating, specifier: "%.2f")")
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.yellow)
                }
            }
            Spacer()
        }
        .cornerRadius(4)
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.black, lineWidth: 1)
        )
        .contentShape(Rectangle())
    }
}

struct GameRowView_Previews: PreviewProvider {
    static var previews: some View {
        GameRowView(
            game: Game(
                id: 0,
                released: "tes",
                name: "tes",
                background_image: "https://media.rawg.io/media/games/84d/84da2ac3fdfc6507807a1808595afb12.jpg",
                rating: 4.7
            )
        )
    }
}
