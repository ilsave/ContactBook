//
//  ViewController.swift
//  ContactBookFinal
//
//  Created by Gushchin Ilya on 31.03.2021.
//

import UIKit
import ContactsUI
import UserNotifications

class ViewControllerContacts: UIViewController {
    

    
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
    @IBAction func newContactPressed(_ sender: Any) {
        print("you touched")
        let vc = CNContactViewController(forNewContact: nil)
        vc.delegate = self
        present(UINavigationController(rootViewController: vc), animated: true)
    }
    
}

extension ViewControllerContacts: CNContactViewControllerDelegate{
    func contactViewController(_ viewController: CNContactViewController, didCompleteWith contact: CNContact?) {
        print("happened!")
        print(contact?.birthday?.day as Any)
        print(contact?.birthday?.calendar as Any)
        print(contact?.birthday?.date as Any)
        print(contact?.birthday?.day as Any)
        guard let contact = contact, let phoneNumber = (contact.phoneNumbers.first?.value)?.stringValue else {
            print("we have problems")
            return
        }
        print(contact.birthday?.day)
        print(contact.birthday?.calendar)
        print(contact.birthday?.date)
        print(contact.birthday?.day)
        let contactBd = Contact(
            recordId: UUID().uuidString,
            firstName: contact.givenName,
            lastName: contact.familyName,
            phone: phoneNumber)
        contacts.append(Contact(
                            recordId: UUID().uuidString,
                            firstName: contact.givenName,
                            lastName: contact.familyName,
                            phone: phoneNumber))
        
        print("lalal")
        
        guard let docDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
                else { return }

        let fileName = "file.txt"
        print("lalal")
                // Build final output URL.
        let outputURL = docDirectoryURL.appendingPathComponent(fileName)
        
        print(docDirectoryURL.path)
        
        do {
            // Encoder, to encode our data.
            let jsonEncoder = JSONEncoder()
            
            // Convert our Object into a Data object.
            let jsonCodedData = try jsonEncoder.encode(contactBd)
            
            // Write the data to output.
            try jsonCodedData.write(to: outputURL)
        } catch {
            // Error Handling.
            print("Failed to write to file \(error.localizedDescription)")
            return
        }
        
//        let content = UNMutableNotificationContent()
//        content.title = "Title"
//        content.body = "Body"
//        content.sound = UNNotificationSound.default
//
//        let gregorian = Calendar(identifier: .gregorian)
//        let now = Date()
//        var components = gregorian.dateComponents([.year, .month, .day, .hour, .minute, .second], from: now)
//
//        // Change the time to 7:00:00 in your locale
//        components.hour = 17
//        components.minute = 53
//        components.second = 0
//
//        let date = gregorian.date(from: components)!
//
//        let triggerDaily = Calendar.current.dateComponents([.hour,.minute,.second,], from: date)
//        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
//
//
//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//        print("INSIDE NOTIFICATION")
//
//        UNUserNotificationCenter.current().add(request, withCompletionHandler: {(error) in
//            if let error = error {
//                print("SOMETHING WENT WRONG")
//            }
//        })
//
        let center = UNUserNotificationCenter.current()
                
                center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
                }
                
              
                let content = UNMutableNotificationContent()
                content.title = "Allo che tam s dengami?"
                content.body = "Tu komy zvonish?"
                
                
                let date = Date().addingTimeInterval(7)
                
                let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
                
                let uuidString = UUID().uuidString
                
                let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        
    }
    func contactViewController(_ viewController: CNContactViewController, shouldPerformDefaultActionFor property: CNContactProperty) -> Bool {
        print(property.contact.birthday as Any)
        return true
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



