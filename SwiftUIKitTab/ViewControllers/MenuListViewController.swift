//
//  ViewController.swift
//  SwiftUIKitTab
//
//  Created by Justus Aype Jose on 13/08/22.
//

import UIKit

class MenuListTableViewCell: UITableViewCell {
    
}

class MenuListViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var refreshButton: UIBarButtonItem!
    
    private let myTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MenuListTableViewCell.self, forCellReuseIdentifier: "MenuListTableViewCell")
        return tableView
    }()
    private var listOfItems: [String] = ["Tennis", "Golf", "Basketball"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Menu List"

        self.view .addSubview(self.myTableView)
        self.myTableView.frame = self.view.bounds
        self.myTableView.dataSource = self
        
        self.loadData()
        
    }

    @IBAction func refreshButtonTapped(_ sender: Any) {
        
        self.listOfItems = ["Tennis", "Golf", "Basketball"]
        self.myTableView.reloadData()
        self.loadData()

    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listOfItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuListTableViewCell", for: indexPath) as? MenuListTableViewCell else {
            fatalError()
        }
        cell.textLabel?.text = self.listOfItems[indexPath.row]
        return cell
                
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Async Await example"
    }

    private func loadData() {
        Task.init {
            do {
                self.listOfItems = try await APIManager.shared.fetchDataAsyncAwait()
                DispatchQueue.main.async {
                    self.myTableView.reloadData()
                }
            } catch(let exception) {
                print("Exception \(exception)")
            }
        }
    }
}

