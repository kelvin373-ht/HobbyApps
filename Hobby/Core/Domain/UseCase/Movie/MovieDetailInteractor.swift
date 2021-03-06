//
//  MovieDetailInteractor.swift
//  CapStoneApps
//
//  Created by Kelvin HT on 1/12/21.
//  Copyright © 2021 Kelvin HT. All rights reserved.
//

import Combine

class MovieDetailInteractor: MovieDetailProtocol {
    private let movieLocaleRepository: MovieLocaleRepositoryProtocol
    private let repository: MovieRepositoryProtocol
    private let category: MovieModel

    required init(
        repository: MovieRepositoryProtocol,
        repositoryLocale: MovieLocaleRepositoryProtocol,
        category: MovieModel
    ) {
        self.repository = repository
        self.category = category
        self.movieLocaleRepository = repositoryLocale
    }

    func getDetailMovie() -> MovieModel {
        return category
    }

    func addMovieFavorite(movie: MovieEntity) -> AnyPublisher<Bool, Error> {
        return movieLocaleRepository.addLocaleMovie(from: movie)
    }

    func deleteMovieFavorite(movie: MovieEntity) {
        movieLocaleRepository.deleteLocaleMovie(from: movie) { _ in
            print("Delete Movie Favorite")
        }
    }

    func checkFavoriteMovie(movie: MovieEntity) -> Bool {
        return movieLocaleRepository.checkLocaleMovie(from: movie)
    }
}
