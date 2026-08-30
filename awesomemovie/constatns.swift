//
//  constance.swift
//  blossommowie
//
//  Created by Danya on 09.08.2026.
//

import Foundation
import SwiftUI
struct Constatns{
    static let homeString = "Home"
    static let upcomingString = "Upcoming"
    static let searchString = "Search"
    static let savedString = "Saved"
    static let saveString = "Save"
    
    static let playString = "Play"
    static let trendingsMowieString = "Trending Mowies"
    static let trendingTVString = "Trending TV"
    static let topRatedMowieString = "Top Rated Mowies"
    static let topRatedTVString = "Top Rated TV"
    static let movieSearchString = "Movie Search"
    static let TVSearchString = "TV Search"
    static let moviePlaceHolderString = "Search for a Movie"
    static let TVPlaceHolderString = "Search for a TV Show"

    
    static let homeIconString = "house"
    static let upcomingIconString = "play.circle"
    static let searchIconString = "magnifyingglass"
    static let savedIconString = "star.hexagon"
    static let tvIconString = "tv"
    static let movieIconString = "movieclapper"

    
    
    static let testTitleURL = "https://m.media-amazon.com/images/M/MV5BYjkwNzVlNDEtMTJlNy00OTdlLTljYWItM2RkZmZkYzY3YjM2XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg"
    static let testTitleURL2 = "https://avatars.mds.yandex.net/get-kinopoisk-image/1600647/57848557-b670-40ea-8a07-fe234700c990/3840x"
    static let testTitleURL3 = "https://avatars.mds.yandex.net/get-kinopoisk-image/10768063/0c078cc9-530e-4626-b0e5-e1719f4d7fe2/3840x"
    
    static let posterURLStart = "https://image.tmdb.org/t/p/w500"
    
    static func addPosterPath(to titles: inout[Title]){
        for index in titles.indices{
            if let path = titles[index].posterPath{
                titles[index].posterPath = Constatns.posterURLStart + path
            }
        }
    }
    
}


enum YoutubeURLStrings: String {
    case trailer = "trailer"
    case queryShorten = "q"
    case space = " "
    case key = "key"
}

extension Text {
 func ghostButton() -> some View {
     self
         .frame(width: 100,height: 50)
         .foregroundStyle(.buttonText)
         .bold()
         .background {
             RoundedRectangle(cornerRadius: 20, style: .continuous)
                 .stroke(.buttonBorder1, lineWidth: 5)
         }
        
    }
}

extension Text {
 func errorMessage() -> some View {
     self
         .foregroundStyle(.red)
         .padding()
         .background(.ultraThinMaterial)
         .clipShape(.rect(cornerRadius:10))

         
        
    }
}

   
 
