//
//  Pizza.swift
//  PizzaCommand
//
//  Created by Juba S on 19/03/2019.
//  Copyright © 2019 Juba S. All rights reserved.
//

import Foundation

import UIKit

class Pizza{
    var pizzaTitle : String
    var pizzaIngredients: Array<String>
    
    init(pizzaTitle: String, pizzaIngredients: Array<String>) {
        self.pizzaTitle = pizzaTitle
        self.pizzaIngredients = pizzaIngredients
    }
}
