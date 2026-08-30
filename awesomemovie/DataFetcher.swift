//
//  DataFetcher.swift
//  blossommowie
//
//  Created by Danya on 15.08.2026.
//

import Foundation
struct DataFetcher{
    
    let tmdbBaseURL = APIConfig.shared?.tmdbBaseURL
    let tmdbAPIKey = APIConfig.shared?.tmdbAPIKey
    let youtubeSearchURL = APIConfig.shared?.youtubeSearchURL
    let youtubeAPIKey = APIConfig.shared?.youtubeAPIKey
    
    
    func fetchTitles(for media:String, by type:String, with title:String? = nil) async throws -> [Title]{
        let fetchTitlesURL = try buildURL(media: media, type: type,searchPhrase: title)
        guard let fetchTitlesURL = fetchTitlesURL else{
            throw NetworkError.urlBuildFailed
        }
        

        

        print(fetchTitlesURL)
        var titles = try await fetchandDecode(url: fetchTitlesURL, type: TMDBAPIObject.self).results
        
       
        Constatns.addPosterPath(to: &titles)
        return titles
        
    }
    
    
  
    
    
    func fetchVideoId(for title: String) async throws -> String{
        guard let baseSearchURL = youtubeSearchURL else {
            throw NetworkError.missingConfig
        }
        
        guard let searchAPIKey = youtubeAPIKey else {
            throw NetworkError.missingConfig
        }
        let trailerSearch = title + YoutubeURLStrings.space.rawValue + YoutubeURLStrings.trailer.rawValue
        
        guard let fetchVideoURL = URL(string : baseSearchURL)?.appending(queryItems: [
            URLQueryItem(name: YoutubeURLStrings.queryShorten.rawValue, value: trailerSearch),
            URLQueryItem(name: YoutubeURLStrings.key.rawValue, value: searchAPIKey)
        ])else{
            throw NetworkError.urlBuildFailed
        }
        print(fetchVideoURL)
        
        return try await fetchandDecode(url: fetchVideoURL, type: YoutubeSearchResponse.self).items?.first?.id?.videoId ?? ""
    }
    func fetchandDecode<T:Decodable>(url: URL, type: T.Type) async throws ->T {
        let(data, urlResponse) = try await URLSession.shared.data(from: url)
        
        guard let response = urlResponse as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badURLResponse(underlyingError: NSError(
                domain: "DataFetcher",
                code: (urlResponse as? HTTPURLResponse)?.statusCode ?? -1,
                userInfo: [NSLocalizedDescriptionKey: "Invalid HTTP Response"]))
            
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(type, from:data)
        
    }
    
    private func buildURL(media:String,type:String,searchPhrase:String? = nil) throws -> URL?{
        guard let baseURL = tmdbBaseURL else {
            throw NetworkError.missingConfig
        }
        guard let apiKey = tmdbAPIKey else {
            throw NetworkError.missingConfig
        }
        
        var path:String
        
        if type == "trending" {
            path = "3/\(type)/\(media)/day"
        }else if type == "top_rated" || type == "upcoming"{
            path = "3/\(media)/\(type)"
        }else if type == "search"{
            path = "3/\(type)/\(media)"
            
        }else{
            throw NetworkError.urlBuildFailed
        }
        var urlQueryItems = [
            URLQueryItem(name: "api_key", value: apiKey)

            
        ]
        if let searchPhrase {
            urlQueryItems.append(URLQueryItem(name: "query",value: searchPhrase))
        }
        guard let url = URL(string: baseURL)?
            .appending(path: path)
            .appending(queryItems: urlQueryItems)else {
            throw NetworkError.urlBuildFailed
        }
        return url
        
        
        
    }
}

