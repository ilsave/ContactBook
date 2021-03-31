//
//  RecentCallsViewController.swift
//  ContactBookFinal
//
//  Created by Gushchin Ilya on 31.03.2021.
//

import UIKit

class RecentCallsViewController: UIViewController {

    @IBOutlet var tableViewRecentCalls: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableViewRecentCalls.delegate = self
        tableViewRecentCalls.dataSource = self
    }
}

extension RecentCallsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "hey"
        return cell
    }
}

extension RecentCallsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
}
