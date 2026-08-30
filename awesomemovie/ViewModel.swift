//
//  ViewModel.swift
//  blossommowie
//
//  Created by Danya on 15.08.2026.
//

import Foundation

@Observable
class ViewModel {
    enum FetchStatus{
        case notStarted
        case Fetching
        case success
        case failed(underlyingError:Error)
    }
    private(set) var homeStatus: FetchStatus = .notStarted
    private(set) var videoIdStatus: FetchStatus = .notStarted
    private(set) var upcomingStatus: FetchStatus = .notStarted
    
    private let dataFetcher = DataFetcher()
    var trdendingMovies: [Title] = []
    var trendingTV: [Title] = []
    var topRatedMovies: [Title] = []
    var topRatedTV: [Title] = []
    var heroTitle = Title.previewTitles[0]
    var videoId = ""
    var upcomingMovies: [Title] = []
    
    
    func getTitles() async{
        homeStatus = .Fetching
        if trdendingMovies.isEmpty {
            
            do{
                async let tMovies = dataFetcher.fetchTitles(for: "movie", by: "trending")
                async let tTV = dataFetcher.fetchTitles(for: "tv", by: "trending")
                async let TRMovies = dataFetcher.fetchTitles(for: "movie", by: "top_rated")
                async let TRTV = dataFetcher.fetchTitles(for: "tv", by: "top_rated")
                trdendingMovies = try await tMovies
                trendingTV = try await tTV
                topRatedMovies = try await TRMovies
                topRatedTV = try await TRTV
                
                if let title = trdendingMovies.randomElement(){
                    heroTitle = title
                }
                homeStatus = .success

                
            }catch{
                print(error)
                homeStatus = .failed(underlyingError: error)
                
            }
        }else{
            homeStatus = .success
        }
    }
    func getVideoId(for title: String) async {
        videoIdStatus = .Fetching
        
        do{
            videoId = try await dataFetcher.fetchVideoId(for: title)
            videoIdStatus = .success
        }catch{
            print(error)
            videoIdStatus = .failed(underlyingError: error)
        }
        
    }
    
    func getUpcomingMovies() async {
        upcomingStatus = .Fetching
        do{
            upcomingMovies = try await dataFetcher.fetchTitles(for: "movie", by: "upcoming")
            upcomingStatus = .success
        }catch{
            print(error)
            upcomingStatus = .failed(underlyingError: error)
            
        }
    }
}
