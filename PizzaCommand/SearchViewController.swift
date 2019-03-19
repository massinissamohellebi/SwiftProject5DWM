//
//  SearchViewController.swift
//  PizzaCommand
//
//  Created by Juba S on 19/03/2019.
//  Copyright © 2019 Juba S. All rights reserved.
//

import UIKit
import SwiftSoup

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
  
    

    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pizzas: [Pizza] = []
    var searching = false
    
    var searchedPizzas: [Pizza] = []
    
    func createArray() -> [Pizza]{
        var tempPizzas:[Pizza] = []
        
        let semaphore = DispatchSemaphore(value: 0)
        
        let url = URL(string: "http://127.0.0.1:8080/recettes")!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            let  htmlContent = String(data: data, encoding: .utf8)!
            do{
                let doc = try SwiftSoup.parse(htmlContent)
                do{
                    let element = try doc.select("h1")
                    for el in element {
                        let text = try el.text()
                        print(text)
                        let pizza = Pizza(pizzaTitle: String(text), pizzaIngredients:[String(text)])
                        tempPizzas.append(pizza)
                        
                    }
                    semaphore.signal()
                    
                }catch{
                    
                }
                
            }catch{
                
            }
            
        }
        
        task.resume()
        semaphore.wait()
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
            let pizza = pizzas[indexPath.row]
            
            var ingredients = ""
            for ing in pizza.pizzaIngredients {
                ingredients = ingredients + ing + ", "
            }
            
            cell?.textLabel?.text = pizza.pizzaTitle
            cell?.detailTextLabel?.text = ingredients
            
        }else{
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
        if searchText == "" {
            searching = false
        }else{
            searchedPizzas = pizzas.filter({( pizza : Pizza) -> Bool in
                return pizza.pizzaTitle.lowercased().contains(searchText.lowercased())
            })
            searching = true
        }
        searchTableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        pizzas = createArray()
    }
}

