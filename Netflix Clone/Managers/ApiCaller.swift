//
//  ApiCaller.swift
//  Netflix Clone
//
//  Created by Moamen on 07/04/2024.
//

import Foundation

struct Constants {
    static let API_KEY = "66a64ba40a6c32abe5ca5c3b5fb4c2ef"
    static let baseUrl = "https://api.themoviedb.org"
    static let YoutubeAPI_KEY = "AIzaSyD6bXgzhD6Vx2mCgo06Wvqij1V2Bu8E2w4"
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"

}
enum APIError : Error {
    case failedData
}
class ApiCaller {
    static let shared = ApiCaller()
    
    func getTrending(completion : @escaping (Result<[Title] ,Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseUrl)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, respond, error in
            guard let data = data , error == nil else {
                return
            }
            do{
                let results = try JSONDecoder().decode(TrendingResponse.self , from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedData))
            }
        }
        task.resume()
    }
    
    func getTrendingTvs(completion : @escaping (Result<[Title] ,Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseUrl)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data , URLResponse , Error in
            guard let data = data , Error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingResponse.self , from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedData))
            }
        }
        task.resume()
    }
    
    func getUpcoming(completion : @escaping (Result<[Title] ,Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseUrl)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data , URLResponse , Error in
            guard let data = data , Error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingResponse.self , from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedData))

            }
        }
        task.resume()
    }
    
    func getPopular(completion : @escaping (Result<[Title] ,Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseUrl)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data , URLResponse , Error in
            guard let data = data , Error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingResponse.self , from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedData))

            }
        }
        task.resume()
    }
    
    
    
    func getTopRated(completion : @escaping (Result<[Title] ,Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseUrl)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data , URLResponse , Error in
            guard let data = data , Error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingResponse.self , from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedData))
            }
        }
        task.resume()
        
        
    }
    func getSearches(completion : @escaping (Result<[Title] ,Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseUrl)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return }
        let task = URLSession.shared.dataTask(with: url) { data , _ , error in
            guard let data = data , error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingResponse.self , from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedData))
            }
        }
        task.resume()
    }
    
    func search(with query: String, completion: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.baseUrl)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingResponse.self, from: data)
                completion(.success(results.results))

            } catch {
                completion(.failure(APIError.failedData))
            }

        }
        task.resume()
    }
    
    func getMovie(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void) {
        

        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.YoutubeBaseURL)q=\(query)&key=\(Constants.YoutubeAPI_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                
                completion(.success(results.items[0]))
                
            } catch {
                completion(.failure(error))
                print(error.localizedDescription)
            }

        }
        task.resume()
    }
    
    
    
}
