//
//  ViewController.swift
//  PizzaCommand
//
//  Created by Juba S on 19/03/2019.
//  Copyright © 2019 Juba S. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var pizzas: [Pizza] = []
    
    func createArray() -> [Pizza]{
        var tempPizzas:[Pizza] = []
        let pizza1 = Pizza(pizzaTitle: "Pizza au jambon", pizzaIngredients:["olive", "jambon", "tomate"])
        let pizza2 = Pizza(pizzaTitle: "Pizza Vegetarienne", pizzaIngredients:["olive", "champignons", "tomate"])
        tempPizzas.append(pizza1)
        tempPizzas.append(pizza2)
        
        return tempPizzas
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pizzas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pizza = pizzas[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        cell.setPizza(pizza: pizza)
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pizzas = createArray()
        
    }


}
