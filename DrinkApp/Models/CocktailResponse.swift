//
//  CocktailResponse.swift
//  DrinkApp
//
//  Created by Bartosz Rzechółka on 24/08/2022.
//

import Foundation

struct CocktailsResponse: Codable {
    let drinks: [CocktailData]
}

struct CocktailData: Codable {
    let id: String
    let name: String
    let glass: String?
    let instructions: String?
    let imageURL: String?
    let alcoholCategory: String?
    let category: String?
    let ingredient1: String?
    let ingredient2: String?
    let ingredient3: String?
    let ingredient4: String?
    let ingredient5: String?
    let ingredient6: String?
    let ingredient7: String?
    let measure1: String?
    let measure2: String?
    let measure3: String?
    let measure4: String?
    let measure5: String?
    let measure6: String?
    let measure7: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case category = "strCategory"
        case alcoholCategory = "strAlcoholic"
        case glass = "strGlass"
        case instructions = "strInstructions"
        case imageURL = "strDrinkThumb"
        case ingredient1 = "strIngredient1"
        case ingredient2 = "strIngredient2"
        case ingredient3 = "strIngredient3"
        case ingredient4 = "strIngredient4"
        case ingredient5 = "strIngredient5"
        case ingredient6 = "strIngredient6"
        case ingredient7 = "strIngredient7"
        case measure1 = "strMeasure1"
        case measure2 = "strMeasure2"
        case measure3 = "strMeasure3"
        case measure4 = "strMeasure4"
        case measure5 = "strMeasure5"
        case measure6 = "strMeasure6"
        case measure7 = "strMeasure7"
    }
}


