//
//  MovieFavoritePresenter.swift
//  CapStoneApps
//
//  Created by Kelvin HT on 1/17/21.
//  Copyright © 2021 Kelvin HT. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import Core
import Category

class MovieFavoritePresenter<DataModel, U: FavoriteProtocol>: ObservableObject
where U.Response == [DataModel] {

    private var cancellables: Set<AnyCancellable> = []
    private let movieRouter = MovieRouter()

    private let movieFavoriteUseCase: U

    @Published var movie: [DataModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false

    init(movieFavoriteUseCase: U) {
        self.movieFavoriteUseCase = movieFavoriteUseCase
    }

    func getLocaleMovies() {
        loadingState = true
        movieFavoriteUseCase.getDataFavorite()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.loadingState = false
                case .failure:
                    self.errorMessage = String(describing: completion)
                }
            }, receiveValue: { movies in
                self.movie = movies
        }).store(in: &cancellables)
    }

    func linkBuilder<Content: View>(
        for category: MovieModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(destination: movieRouter.goToMovieDetailView(for: category)) { content() }
    }
}
