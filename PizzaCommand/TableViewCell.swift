//
//  TableViewCell.swift
//  PizzaCommand
//
//  Created by Juba S on 19/03/2019.
//  Copyright © 2019 Juba S. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var pizzaTitle: UILabel!
    
    func setPizza(pizza: Pizza){
        pizzaTitle.text = pizza.pizzaTitle
    }
}
