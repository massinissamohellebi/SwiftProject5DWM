//
//  ViewController.swift
//  PizzaCommand
//
//  Created by Juba S on 19/03/2019.
//  Copyright © 2019 Juba S. All rights reserved.
//

import UIKit
import SwiftSoup

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var pizzas: [Pizza] = []
    
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
