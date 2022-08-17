//
//  NetworkListViewController.swift
//  SwiftUIKitTab
//
//  Created by Justus Aype Jose on 16/08/22.
//

import Foundation
import UIKit
import Combine

class NetworkListCell: UITableViewCell {
    
}

class NetworkListViewController: UIViewController, UITableViewDataSource {
    
    private var listOfItems: [String] = ["Bell", "Rogers"]
    private var observer: AnyCancellable?
    
    private var myTableView: UITableView = {
        let table = UITableView()
        table.register(NetworkListCell.self, forCellReuseIdentifier: "NetworkListCell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view .addSubview(myTableView)
        myTableView.frame = self.view.bounds
        myTableView.dataSource = self
        
        
        observer = APIManager.shared.fetchDataCombine()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch (completion) {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print(error)
                }
                
            }, receiveValue: { [weak self] values in
                if values.count > 0 {
                    self?.listOfItems = values
                    self?.myTableView.reloadData()
                }
            })
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listOfItems.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Futures + Combine Working"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NetworkListCell", for: indexPath) as? NetworkListCell else {
            fatalError()
        }
        cell.textLabel?.text = self.listOfItems[indexPath.row]
        return cell
        
    }
    
}

