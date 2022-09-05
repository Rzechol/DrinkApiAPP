//
//  Cocktails.swift
//  DrinkApp
//
//  Created by Bartosz Rzechółka on 24/08/2022.
//

import Foundation
import OrderedCollections

enum CocktailCategory: String {
    case coffeeOrTea = "Coffee / Tea"
    case shake = "Shake"
    case homemadeLiqueur = "Homemade Liqueur"
    case other = "Other/Unknown"
    case cocoa = "Cocoa"
    case ordinary = "Ordinary Drink"
    case cocktail = "Cocktail"
    case party = "Punch / Party Drink"
    case beer = "Beer"
    case shot = "Shot"
    case soft = "Soft Drink"
}

enum CocktailAlcoholCategory: String {
    case alcoholic = "Alcoholic"
    case nonAlcoholic = "Non alcoholic"
    case optional = "Optional alcohol"
}

struct Cocktail {
    let id: String
    let name: String
    let glass: String
    let instructions: String
    let imageURL: String
    let alcoholCategory: CocktailAlcoholCategory
    let category: CocktailCategory
    var ingredients: OrderedDictionary<String, String> = [:]
    
    init(from cocktailData: CocktailData) {
        self.id = cocktailData.id
        self.name = cocktailData.name
        self.glass = cocktailData.glass ?? ""
        self.instructions = cocktailData.instructions ?? ""
        self.imageURL = cocktailData.imageURL ?? ""
        
        if let alcoholCategory = cocktailData.alcoholCategory {
            self.alcoholCategory = CocktailAlcoholCategory(rawValue: alcoholCategory) ?? .alcoholic
        } else {
            self.alcoholCategory = .alcoholic
        }
        
        if let category = cocktailData.category {
            self.category = CocktailCategory(rawValue: category) ?? .other
        } else {
            self.category = .other
        }
        
        if let ingredient1 = cocktailData.ingredient1 {
            self.ingredients[ingredient1] = cocktailData.measure1 ?? ""
        }
        if let ingredient2 = cocktailData.ingredient2 {
            self.ingredients[ingredient2] = cocktailData.measure2 ?? ""
        }
        if let ingredient3 = cocktailData.ingredient3 {
            self.ingredients[ingredient3] = cocktailData.measure3 ?? ""
        }
        if let ingredient4 = cocktailData.ingredient4 {
            self.ingredients[ingredient4] = cocktailData.measure4 ?? ""
        }
        if let ingredient5 = cocktailData.ingredient5 {
            self.ingredients[ingredient5] = cocktailData.measure5 ?? ""
        }
        if let ingredient6 = cocktailData.ingredient6 {
            self.ingredients[ingredient6] = cocktailData.measure6 ?? ""
        }
        if let ingredient7 = cocktailData.ingredient7 {
            self.ingredients[ingredient7] = cocktailData.measure7 ?? ""
        }
       
    }
}

