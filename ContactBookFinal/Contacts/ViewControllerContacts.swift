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
    private var output: ContactsViewOutput!

    @IBOutlet var tableViewContacts: UITableView!
    
    
    @IBOutlet var indicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let presenter = ContactsPresenter(contactsRepository: Services.factory.getContactsRepository(), callHistoryRepository: Services.factory.getCallHistoryRepository())
        presenter.view = self
        output = presenter
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.viewOpened()
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

extension ViewControllerContacts: ContactsView {
    func showContacts(_ contacts: [Contact]) {
        self.contacts = contacts
        tableViewContacts.reloadData()
    }
    
    

    func showProgress() {
        tableViewContacts.isHidden = true
        indicator.startAnimating()
    }
    
    func hideProgress() {
        indicator.stopAnimating()
        tableViewContacts.isHidden = false
    }
    
    
   
    
    func showError(_ error: Error) {
        
    }
}



