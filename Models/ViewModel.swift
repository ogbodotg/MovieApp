//
//  ViewModel.swift
//  MovieApp
//
//  Created by OGBODO on 22/02/2026.
//

import Foundation

@Observable
class ViewModel{
    enum FetchStatus{
        case notStarted
        case fetching
        case success
        case failed(underlyingError: Error)
    }
    
    private(set) var homeStatus: FetchStatus = .notStarted
    private(set) var videoIdStatus: FetchStatus = .notStarted
    private(set) var upcomingStatus: FetchStatus = .notStarted
    
    private let dataFetcher = DataFetcher()
    var trendingMovies: [Title] = []
    var trendingTvShows: [Title] = []
    var topRatedMovies: [Title] = []
    var topRatedTvShows: [Title] = []
    var upComingMovies: [Title] = []
    var heroTitle = Title.previewTitles[0]
    var videoId = ""
    
    private var fetchTask: Task<Void, Never>?
    
    func getTitles() async {
        fetchTask?.cancel()
        fetchTask = Task{[weak self] in guard let self else {return}}
        
        let hasAllData = !trendingMovies.isEmpty &&
        !trendingTvShows.isEmpty &&
        !topRatedMovies.isEmpty &&
        !topRatedTvShows.isEmpty
        
        if hasAllData {
            homeStatus = .success
            return
        }
        homeStatus = .fetching
     
            
            do {
                async let trendingMoviesTask = dataFetcher.fetchTitles(for: .movie, by: .trending)
                async let trendingTvShowTask = dataFetcher.fetchTitles(for: .tv, by: .trending)
                async let topRatedMoviesTask = dataFetcher.fetchTitles(for: .movie, by: .topRated)
                async let topRatedTvShowTask = dataFetcher.fetchTitles(for: .tv, by: .topRated)
                
                trendingMovies = try await trendingMoviesTask
                trendingTvShows = try await  trendingTvShowTask
                topRatedMovies = try await  topRatedMoviesTask
                topRatedTvShows = try await topRatedTvShowTask
                
                if let title = trendingMovies.randomElement(){
                    heroTitle = title
                }
                homeStatus = .success
                
            } catch is CancellationError {
                // ignore
            } catch{
                homeStatus = .failed(underlyingError: error)
            }
        
    }
    
    func getVideoId(for title: String) async {
        videoIdStatus = .fetching
        
        do {
            videoId = try await dataFetcher.fetchVideoId(for: title)
            videoIdStatus = .success
        }catch {
            print("Error fetching videoID \(error)")
            videoIdStatus = .failed(underlyingError: error)
        }
    }
    
    func getUpComingMovies() async {
        upcomingStatus = .fetching
        
        do {
            upComingMovies = try await dataFetcher.fetchTitles(for: .movie, by: .upComing)
            upcomingStatus = .success
        } catch {
            print("Error fetching upcoming movies \(error)")
            upcomingStatus = .failed(underlyingError: error)
        }
    }
}
