//
//  APIConfig.swift
//  blossommowie
//
//  Created by Danya on 12.08.2026.
//

import Foundation

struct APIConfig: Decodable {
    let tmdbBaseURL: String
    let tmdbAPIKey: String
    let youtubeBaseURL: String
    let youtubeAPIKey: String
    let youtubeSearchURL: String
    
    
    static let shared: APIConfig? = {
        do{
            return try loadCofig()
        }catch{
            print("Failed to load API config: \(error.localizedDescription)")
            return nil
        }

            
        }()
    
    
    private static func loadCofig() throws -> APIConfig {
        guard let URL = Bundle.main.url(forResource: "APIConfig", withExtension: "json") else {
            throw APIConfigError.fileNotFound        }
        
        
        do{
            let data = try Data(contentsOf: URL)
            return try JSONDecoder().decode(APIConfig.self, from: data)
        }catch let error as DecodingError{
            throw APIConfigError.decodingFailed(underlyingError: error)
        }catch{
            throw APIConfigError.dataLoadingFailed(underlyingError: error)
        }
        
    }
    
}




