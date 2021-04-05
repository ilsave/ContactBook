//
//  RecentCallsViewController.swift
//  ContactBookFinal
//
//  Created by Gushchin Ilya on 31.03.2021.
//

import UIKit

class RecentCallsViewController: UIViewController {

    @IBOutlet var tableViewRecentCalls: UITableView!
    
    var recentCalls: [CallRecord] = []
    let callHistoryRepository = Services.factory.getCallHistoryRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        let nib = UINib(nibName: "RecentTableViewCell", bundle: nil)
        tableViewRecentCalls.register(nib, forCellReuseIdentifier: "RecentTableViewCell")
        
        tableViewRecentCalls.delegate = self
        tableViewRecentCalls.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        do{
            recentCalls = try callHistoryRepository.getHistory()
            print("size of calls \(recentCalls.count)")
            tableViewRecentCalls.reloadData()
        } catch {
            print(error)
        }
    }
}

extension RecentCallsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentCalls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecentTableViewCell", for: indexPath) as! RecentTableViewCell
        cell.nameTitle?.text = recentCalls[indexPath.row].phone
        cell.timeTitle?.text = recentCalls[indexPath.row].timestamp
        return cell
    }
}

extension RecentCallsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
}
