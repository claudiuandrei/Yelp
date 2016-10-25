//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Claudiu Andrei on 10/24/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

protocol FiltersViewDelegate: class {
    func useFilters(controller: FiltersViewController, deals: Bool, categories: [String])
}

class FiltersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ToggleCellDelegate {
    
    weak var delegate: FiltersViewDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func dismissFilters(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func useFilters(_ sender: AnyObject) {
        var _categories: [String] = []
        for (category, on) in self.categories {
            if on == true {
                _categories.append(category)
            }
        }
        delegate?.useFilters(controller: self, deals: self.deals, categories: _categories)
        dismiss(animated: true, completion: nil)
    }
    
    // Setup the data
    var deals: Bool = false
    var categories: [String:Bool] = ["thai": true, "korean": false, "sushi": false, "newamerican": true]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the tableview
        tableView.delegate = self
        tableView.dataSource = self
        

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0:
                return 1
            default:
                return categories.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func updateCellToggle(cell: ToggleCell, value: Bool) {
        switch cell.type {
            case "Deals":
                self.deals = value
            default:
                self.categories[cell.name] = value
        }
        print(value)
        print(self.categories)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToggleCell", for: indexPath) as! ToggleCell
        cell.delegate = self
        
        switch indexPath.section {
            case 0:
                cell.name = "Popular"
                cell.toggle = false
            default:
                cell.type = "Category"
                let name = Array(categories.keys)
                cell.name = name[indexPath.row]
                let toggle = Array(categories.values)
                cell.toggle = toggle[indexPath.row]
        }

        
        return cell
    }

    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
