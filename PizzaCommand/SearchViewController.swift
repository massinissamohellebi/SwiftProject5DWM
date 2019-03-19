//
//  SearchViewController.swift
//  PizzaCommand
//
//  Created by Juba S on 19/03/2019.
//  Copyright © 2019 Juba S. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
  
    

    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pizzas: [Pizza] = []
    var searching = false
    
    var searchedPizzas: [Pizza] = []
    
    func createArray() -> [Pizza]{
        var tempPizzas:[Pizza] = []
        let pizza1 = Pizza(pizzaTitle: "Pizza au jambon", pizzaIngredients:["olive", "jambon", "tomate"])
        let pizza2 = Pizza(pizzaTitle: "Pizza Vegetarienne", pizzaIngredients:["olive", "champignons", "tomate"])
        let pizza3 = Pizza(pizzaTitle: "Pizza Thon", pizzaIngredients:["olive", "Thon", "tomate"])
        tempPizzas.append(pizza1)
        tempPizzas.append(pizza2)
        tempPizzas.append(pizza3)
        
        return tempPizzas
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching == false {
            return pizzas.count
        }else{
            return searchedPizzas.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: "searchCell")
        
        if searching == false {
            
            print("no search")
            let pizza = pizzas[indexPath.row]
            
            var ingredients = ""
            for ing in pizza.pizzaIngredients {
                ingredients = ingredients + ing + ", "
            }
            
            cell?.textLabel?.text = pizza.pizzaTitle
            cell?.detailTextLabel?.text = ingredients
            
        }else{
            print("search")
            let pizza = searchedPizzas[indexPath.row]
            
            var ingredients = ""
            for ing in pizza.pizzaIngredients {
                ingredients = ingredients + ing + ", "
            }
            
            cell?.textLabel?.text = pizza.pizzaTitle
            cell?.detailTextLabel?.text = ingredients
        }
        
        return cell!
    }
    
    
    
    func searchBar(_ searchBar:UISearchBar, textDidChange searchText: String){
        searchedPizzas.removeAll()
        if searchText == "" {
            searching = false
        }else{
            let pizza1 = Pizza(pizzaTitle: "Pizza Search", pizzaIngredients:["olive", "jambon", "tomate"])
            searchedPizzas.append(pizza1)
            searching = true
        }
        searchTableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        pizzas = createArray()
    }
}

