//
//  FavoritesViewController.swift
//  SwiftUIKitTab
//
//  Created by Justus Aype Jose on 16/08/22.
//

import Foundation
import UIKit

class FavoritesTableViewCell: UITableViewCell {
    
}

class FavoritesViewController: UIViewController, UITableViewDataSource {

    private var listOfItems: [String] = ["12","wer"]
    
    private let tableView: UITableView = {
        let myTableView = UITableView()
        myTableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: "FavoritesTableViewCell")
        return myTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view .addSubview(self.tableView)
        self.tableView.dataSource = self
        self.tableView.frame = self.view.bounds
        
        APIManager.shared.fetchData { values in
            if values.count > 0 {
                self.listOfItems = values
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Table view Data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesTableViewCell", for: indexPath) as? FavoritesTableViewCell else {
            fatalError()
        }
        cell.textLabel?.text = listOfItems[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Completion Handler Working"
    }
    
}
