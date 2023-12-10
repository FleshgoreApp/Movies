//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Anton Shvets on 07.12.2023.
//

import SwiftUI
import Combine

final class MoviesViewModel: ObservableObject {
    private var topRatedModel = MoviesModel()
    private var popularModel = MoviesModel()
    private var upcomingModel = MoviesModel()
    private var subscriptions = Set<AnyCancellable>()
    private let networkManager: NetworkServiceProtocol
    
    @Published var searchFocused: Bool = false
    @Published var isLoading: Bool = false
    
    var filterText = CurrentValueSubject<String, Never>("")
    var filteredMovies = CurrentValueSubject<[MovieEntity], Never>([])
    
    var categories: [String: [MovieEntity]] {
        [
            "Top Rated": topRatedModel.list,
            "Popular"  : popularModel.list,
            "Upcoming" : upcomingModel.list
        ]
    }
    
    init(networkManager: NetworkServiceProtocol) {
        self.networkManager = networkManager
        fetchAll()
        addSubscriptions()
    }
    
    func onRefresh() {
        topRatedModel = .init()
        popularModel = .init()
        upcomingModel = .init()
        fetchAll()
    }
    
    func fetchAll() {
        Task {
            await withTaskGroup(of: Void.self) { group in
                group.addTask { [weak self] in
                    await self?.fetch(category: .topRated())
                    await self?.fetch(category: .popular())
                    await self?.fetch(category: .upcoming())
                }
            }
        }
    }
    
    func fetch(category type: MoviesRoute.MovieCategoryType) async {
        switch type {
        case .popular:
            guard let response = await fetch(route: popularRoute) else { return }
            await MainActor.run {
                popularModel.update(with: response)
            }
        case .upcoming:
            guard let response = await fetch(route: upcomingRoute)  else { return }
            await MainActor.run {
                upcomingModel.update(with: response)
            }
        case .topRated:
            guard let response = await fetch(route: topRatedRoute)  else { return }
            await MainActor.run {
                topRatedModel.update(with: response)
            }
        }
        
        await MainActor.run {
            objectWillChange.send()
        }
    }
}

//MARK: - Private
extension MoviesViewModel {
    private var topRatedRoute: MoviesRoute {
        .init(type: .topRated(page: topRatedModel.currentPage))
    }
    
    private var popularRoute: MoviesRoute {
        .init(type: .popular(page: popularModel.currentPage))
    }
    
    private var upcomingRoute: MoviesRoute {
        .init(type: .upcoming(page: popularModel.currentPage))
    }
    
    private func addSubscriptions() {
        filterText
            .dropFirst()
            .sink { [weak self] text in
                guard let self else { return }
                searchFocused = !text.isEmpty
                
                let mergedArray = [topRatedModel.list, popularModel.list, upcomingModel.list]
                    .flatMap { $0 }
                    .unique { $0.title }
                
                let filteredList = mergedArray.filter {
                    ($0.title ?? "").lowercased().contains(text.lowercased())
                }
                
                filteredMovies.value = filteredList.sorted(by: { $0.title ?? "" < $1.title ?? "" })
                objectWillChange.send()
            }
            .store(in: &subscriptions)
    }
    
    private func fetch(route: MoviesRoute) async -> MoviesEntity? {
        await MainActor.run { [weak self] in
            self?.isLoading = true
        }
        
        do {
            let response = try await networkManager.sendRequest(
                route: route,
                decodeTo: MoviesEntity.self
            )
            
            await MainActor.run { [weak self] in
                self?.isLoading = false
            }
            return response
        } catch {
            if let error = error as? NetworkRequestError {
                handleError(error)
            } else {
                print(error.localizedDescription)
            }
            
            await MainActor.run { [weak self] in
                self?.isLoading = false
            }
            return nil
        }
    }
    
    private func handleError(_ error: NetworkRequestError) {
        switch error {
        case let .failedDecoded(decodeMessage):
            //some implementation
            print("decodeMessage: \(decodeMessage)")
        case .badURL:
            //some implementation
            print("badURL")
        case let .responseError(statusCode):
            //some implementation
            print("response error \(statusCode)")
        }
    }
}
