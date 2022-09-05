//
//  APICaller.swift
//  DrinkApp
//
//  Created by Bartosz Rzechółka on 24/08/2022.
//

import Foundation

struct APIConstants {
    static let baseURL = "https://www.thecocktaildb.com/api/json/v1"
    
    static let key = "1"
}

enum APIError: Error {
    case failedToGetData
}

struct APICaller {
    static let shared = APICaller()
    
    private init() { }
    
    private func getCocktails(fromURL url: URL, completion: @escaping (Result<[Cocktail], Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else { return }
            do {
                let decoded = try JSONDecoder().decode(CocktailsResponse.self, from: data)
                let cocktails = decoded.drinks.map { cocktailData in
                    Cocktail(from: cocktailData)
                }
                completion(.success(cocktails))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    private func getCocktailDetails(fromURL url: URL, completion: @escaping (Result<Cocktail, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else { return }
            
            do {
                let decoded = try JSONDecoder().decode(CocktailsResponse.self, from: data)
                if let cocktail = decoded.drinks.first {
                    completion(.success(Cocktail(from: cocktail)))
                }
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getCocktails(containing ingredient: String, completion: @escaping (Result<[Cocktail], Error>) -> Void) {
        guard let url = URL(string: "\(APIConstants.baseURL)/\(APIConstants.key)/filter.php?i=\(ingredient)") else { return }
        
        getCocktails(fromURL: url, completion: completion)
    }
    
    func getCocktails(byCategory category: CocktailCategory, completion: @escaping (Result<[Cocktail], Error>) -> Void) {
        guard let url = URL(string: "\(APIConstants.baseURL)/\(APIConstants.key)/filter.php?c=\(category.rawValue.replacingOccurrences(of: " ", with: "_"))") else { return }
        
        getCocktails(fromURL: url, completion: completion)
    }
    
    func getCocktails(byAlcoholCategory category: CocktailAlcoholCategory, completion: @escaping (Result<[Cocktail], Error>) -> Void) {
        guard let url = URL(string: "\(APIConstants.baseURL)/\(APIConstants.key)/filter.php?a=\(category.rawValue.replacingOccurrences(of: " ", with: "_"))") else { return }
        
        getCocktails(fromURL: url, completion: completion)
    }
    
    func getCocktails(byName name: String, completion: @escaping (Result<[Cocktail], Error>) -> Void) {
        guard let url = URL(string: "\(APIConstants.baseURL)/\(APIConstants.key)/search.php?s=\(name)") else { return }
        
        getCocktails(fromURL: url, completion: completion)
    }
    
    func getCocktailDetails(byID id: String, completion: @escaping (Result<Cocktail, Error>) -> Void) {
        guard let url = URL(string: "\(APIConstants.baseURL)/\(APIConstants.key)/lookup.php?i=\(id)") else { return }
        
        getCocktailDetails(fromURL: url, completion: completion)
    }
    
   
}

