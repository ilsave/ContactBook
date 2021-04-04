//
//  Contacts-.swift
//  ContactBookFinal
//
//  Created by Gushchin Ilya on 31.03.2021.
//

import Foundation
import ContactsUI

class ContactsPresenter {
    
    private var contactsRepository: ContactsRepository!
    private var callHistoryRepository: CallHistoryRepository!
    weak var view: ContactsView?

    init(contactsRepository: ContactsRepository, callHistoryRepository: CallHistoryRepository) {
        self.contactsRepository = contactsRepository
        self.callHistoryRepository = callHistoryRepository
    }
}

extension ContactsPresenter: ContactsViewOutput {
    func viewOpened() {
        view?.showProgress()
        async { [weak self] in
            
            guard let self = self else {
                return
            }
            
            defer {
                asyncMain {
                    self.view?.hideProgress()
                }
            }
            
            do {
                let contacts = try self.contactsRepository.getContacts()
                asyncMain {
                    self.view?.showContacts(contacts)
                }
            } catch {
                asyncMain {
                    self.view?.showError(error)
                }
            }
        }
    }
    
    func createNotification(contact: CNContact) {
        guard let birthday = contact.birthday!.date else {
            return
        }
        let center = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .sound]
        center.requestAuthorization(options: options) { (granted, error) in
            if !granted {
                print("Something went wrong \(error)")
            }
        }
        let content = UNMutableNotificationContent()
        content.title = "Don't forget"
        content.body = "Its \(contact.givenName) BirthDay today! Its perfect time to make a call and celebrate!:)))"
        content.sound = UNNotificationSound.default
        print(birthday)
        let gregorian = Calendar(identifier: .gregorian)
        var components = gregorian.dateComponents([.month, .day, .hour, .minute, .second], from: birthday)
        
        components.hour = 16
        components.minute = 37
        components.second = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        
        let identifier = "UYLLocalNotification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        center.add(request, withCompletionHandler: { (error) in
            if let error = error {
                print(error)
            }
        })
        print(components)
        print("Hey we created a notification")
    }
    
    func contactPressed(_ contact: Contact) {
        makeCall(to: contact)
    }
    
    func makeCall(to contact: Contact) {
        
        do {
            try callHistoryRepository.add(record: CallRecord(timestamp: Date(),
                                                             phone: contact.phone))
        } catch {
            view?.showError(error)
        }
    }
    
    func newContactAdded(_ contact: ContactsData) {
        do {
            try contactsRepository.add(contact: contact)
        } catch {
            view?.showError(error)
        }
    }
    
}
