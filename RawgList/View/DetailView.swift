//
//  DetailView.swift
//  RawgList
//
//  Created by IT-Mobile-Dev on 07/08/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    @StateObject private var viewModel: DetailViewModel
    @EnvironmentObject private var manager: PersistenceManager
    @State private var isFavorited = false
    @State private var userRating = 0.0
    @State private var ratingExist = false
    @State private var isEditing = false
    @State private var isLoading = true
    
    private let id: Int
    
    init(id: Int) {
        _viewModel = StateObject(wrappedValue: DetailViewModel(id: id))
        self.id = id
    }
    
    var body: some View {
        ScrollView {
            WebImage(url: URL(string: viewModel.games.background_image))
                .resizable()
                .placeholder(Image(systemName: "photo"))
                .indicator(.activity)
                .scaledToFit()
            VStack {
                Text(viewModel.games.name)
                    .font(.title)
                    .multilineTextAlignment(.center)
                Text(viewModel
                        .games
                        .genres
                        .map{ $0.name }
                        .joined(separator: " - ")
                )
                .font(.subheadline)
                .multilineTextAlignment(.center)
            }
            .padding(4)
            Spacer()
            VStack(alignment: .leading, spacing: 4) {
                Group {
                    StarView(
                        prefix: "Total : ",
                        rating: $viewModel.games.rating,
                        isEditing: .constant(false)
                    )
                    StarView(
                        prefix: "User : ",
                        rating: $userRating,
                        isEditing: $isEditing,
                        isEditable: true
                    ) { rating in
                        if ratingExist {
                            manager.editRating(id, rating)
                        } else {
                            manager.addRating(id, rating)
                            ratingExist = true
                        }
                    }
                    Spacer(minLength: 10)
                }
                Group {
                    Text("Release Date")
                        .font(.title2)
                    Text(viewModel.games.released)
                    Spacer(minLength: 10)
                }
                Group {
                    Text("Description")
                        .font(.title2)
                    Text(viewModel.games.description)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer(minLength: 10)
                }
                Group {
                    Text("Tags")
                        .font(.title2)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.games.tags, id: \.name.self) { tag in
                                Text(tag.name)
                                    .padding(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color.black, lineWidth: 2)
                                    )
                            }
                        }
                        .padding(4)
                    }
                    Spacer(minLength: 10)
                }
                Group {
                    Text("Developers")
                        .font(.title2)
                    VStack(alignment: .leading) {
                        ForEach(
                            viewModel.games.developers,
                            id: \.name.self
                        ) { dev in
                            Text(dev.name)
                        }
                    }
                    Spacer(minLength: 10)
                }
                Group {
                    Text("Platforms")
                        .font(.title2)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(
                                viewModel.games.platforms,
                                id: \.platform.name.self
                            ) { platform in
                                Text(platform.platform.name)
                                    .padding(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color.black, lineWidth: 2)
                                    )
                            }
                        }
                        .padding(4)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity)
        .onAppear {
            viewModel.getData()
            isFavorited = manager.isFavorite(id)
            userRating = manager.getRating(id)
            ratingExist = userRating != 0.0
            isEditing = !ratingExist
        }
        .navigationTitle("Detail")
        .toolbar {
            Button(action: {
                if isFavorited {
                    manager.deleteFavorite(id)
                } else {
                    manager.addFavorite(viewModel.games)
                }
                isFavorited.toggle()
            }) {
                if isFavorited {
                    Image(systemName: "star.fill")
                } else {
                    Image(systemName: "star")
                }
            }
        }
    }
}

struct StarView: View {
    @EnvironmentObject var manager: PersistenceManager
    var prefix: String = ""
    @Binding var rating: Double
    @Binding var isEditing: Bool
    var isEditable = false
    var changeRating: (Double) -> () = { _ in }
    var body: some View {
        HStack {
            Text(prefix)
            if isEditing {
                ForEach(0..<5) { idx in
                    let num = Double(idx)
                    Button(action: {
                        rating = num+1
                        changeRating(num+1)
                        isEditing = false
                    }) {
                        Image(systemName: "star")
                    }
                }
                if rating != 0.0 {
                    Button(action: {
                        isEditing = false
                    }) {
                        Image(systemName: "xmark")
                    }
                }
            } else {
                ForEach(0..<5) { idx in
                    let num = Double(idx)
                    if rating >= num+0.5 {
                        if rating >= num+1.0 {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        } else {
                            Image(systemName: "star.leadinghalf.fill")
                                .foregroundColor(.yellow)
                        }
                    } else {
                        Image(systemName: "star")
                            .foregroundColor(.yellow)
                    }
                }
                Text("\(rating, specifier: "%.2f")")
                if isEditable {
                    Button(action: {
                        isEditing = true
                    }) {
                        Image(systemName: "pencil")
                    }
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(id: 3328)
    }
}
