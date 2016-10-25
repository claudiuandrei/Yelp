//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, FiltersViewDelegate {
    
    var businesses: [Business]! = [Business]()
    
    @IBOutlet weak var tableView: UITableView!
    var searchBar: UISearchBar!
    
    // var isLoading: Bool = false
    var deals: Bool = false
    var categories: [String] = ["thai", "newamerican"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the table view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 112
        
        searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Restaurants"
        navigationItem.titleView = searchBar
        
        // Search the businesses
        getBusinesses()
        
        /* Example of Yelp search with more search options specified
         Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
         self.businesses = businesses
         
         for business in businesses {
         print(business.name!)
         print(business.address!)
         }
         }
         */
        
    }
    
    func getBusinesses() {
        let term = searchBar.text!
        Business.searchWithTerm(term: term, sort: nil, categories: self.categories, deals: self.deals, completion: {
            (businesses: [Business]?, error: Error?) -> Void in
                self.businesses = businesses
                self.tableView.reloadData()
            }
        )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        cell.business = businesses[indexPath.row]
        return cell
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.text = ""
        getBusinesses()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        getBusinesses()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
    
    func useFilters(controller: FiltersViewController, deals: Bool, categories: [String]) {
        self.deals = deals
        self.categories = categories
        getBusinesses()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nav = segue.destination as! UINavigationController
        let filtersView = nav.topViewController as! FiltersViewController
        filtersView.delegate = self
    }
    
    
    // View is scrolling
    /*
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // Loading already, nothing to do
        if isLoading {
            return
        }
        
        // Calculate offset
        let scrollViewContentOffset = scrollView.contentOffset.y
        let tableViewContentOffset = tableView.contentSize.height - tableView.bounds.size.height
        
        
        // Get the next business if we are ok
        if scrollViewContentOffset > tableViewContentOffset {
                getNextBussinesses()
            }
        }
    }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
