//
//  ViewController.swift
//  ContactBookFinal
//
//  Created by Gushchin Ilya on 31.03.2021.
//

import UIKit

class ViewControllerContacts: UIViewController {
    
    struct Contact {
        let recordId: String
        let firstName: String
        let lastName: String
        let phone: String
    }
    
    struct ContactsData {
        let firstName: String
        let lastName: String
        let phone: String
    }

    
    var contacts: [Contact] = []
    

    @IBOutlet var tableViewContacts: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contacts.append(Contact.init(recordId: "1", firstName: "wqwqwq", lastName: "wqwqwq", phone: "wqwqwq"))
        contacts.append(Contact.init(recordId: "1", firstName: "wqwqwq", lastName: "wqwqwq", phone: "wqwqwq"))
        contacts.append(Contact.init(recordId: "1", firstName: "wqwqwq", lastName: "wqwqwq", phone: "wqwqwq"))
        contacts.append(Contact.init(recordId: "1", firstName: "wqwqwq", lastName: "wqwqwq", phone: "wqwqwq"))
        contacts.append(Contact.init(recordId: "1", firstName: "wqwqwq", lastName: "wqwqwq", phone: "wqwqwq"))
        
        let nib = UINib(nibName: "ContactTableViewCell", bundle: nil)
        
        tableViewContacts.register(nib, forCellReuseIdentifier: "ContactTableViewCell")
        tableViewContacts.rowHeight = UITableView.automaticDimension
        tableViewContacts.delegate = self
        tableViewContacts.dataSource = self
    }
    
}

extension ViewControllerContacts: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath)
        as! ContactTableViewCell
        cell.emailLabel?.text = contacts[indexPath.row].phone
        cell.nameLabel?.text = contacts[indexPath.row].firstName + contacts[indexPath.row].lastName
        return cell
    }
}

extension ViewControllerContacts: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

