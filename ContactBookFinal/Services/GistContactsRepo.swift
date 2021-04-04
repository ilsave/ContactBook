//
//  GistContactRepo.swift
//  ContactBookFinal
//
//  Created by Gushchin Ilya on 31.03.2021.
//

import Foundation
import ContactsUI

class GistContactsRepo: ContactsRepository {
    
    
    private let url: URL
    private let decoder: JSONDecoder
    private let databaseName = "Database.json"
    
    private var contacts: [Contact] = []
    
    init(url: URL) {
        self.url = url
        decoder = JSONDecoder()
    }
    
    func getContacts() throws -> [Contact] {
        
        //check if file exists
        guard let docDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
                else { return []}
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        var fileURL: URL? = nil
        let innerUrl = NSURL(fileURLWithPath: path)
        guard let pathComponent = innerUrl.appendingPathComponent(databaseName) else {
            return []
        }
        let filePath = pathComponent.path
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath) {
            print("FILE AVAILABLE \(pathComponent)")
            fileURL = pathComponent
            let data = try Data(contentsOf: fileURL!)
            let jsonDecoder = JSONDecoder()
            let items = try jsonDecoder.decode([Contact].self, from: data)
            return items
        } else {
            print("FILE NOT AVAILABLE \(pathComponent)")
            fileURL = URL(fileURLWithPath: databaseName, relativeTo: docDirectoryURL)
            let jsonEncoder = JSONEncoder()
            let contactsDb = try getContactsFromApi()
            let jsonCodedData2 = try jsonEncoder.encode(contactsDb)
            try jsonCodedData2.write(to: fileURL!)
            return contactsDb
        }
    }
    
    
    func getContactsFromApi() throws -> [Contact] {
        let sem = DispatchSemaphore(value: 0)
        let request = URLRequest(url: url)
        
        var resultError: Error? = nil
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            defer {
                sem.signal()
            }
            
            guard error == nil else {
                resultError = error
                return
            }
            
            guard let data = data else {
                return
            }
            
            struct ContactsResponse: Decodable {
                let firstname: String
                let lastname: String
                let phone: String
                let email: String
            }
            
            do {
                self.contacts = try self.decoder.decode([ContactsResponse].self, from: data).map {
                    Contact(recordId: UUID().uuidString,
                            firstName: $0.firstname,
                            lastName: $0.lastname,
                            phone: $0.phone)
                }
                
            } catch {
                resultError = error
            }
        }
        task.resume()
        // TODO: add timeout
        sem.wait()
        
        
        if let error = resultError {
            throw error
        }
        
        return contacts
    }
    
    func add(contact: ContactsData) throws {
        guard let docDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
                else { return }
        let jsonDecoder = JSONDecoder()
        let jsonEncoder = JSONEncoder()
        
        let innerUrl = URL(fileURLWithPath: docDirectoryURL.absoluteString)
        let pathComponent = innerUrl.appendingPathComponent(databaseName)
        let data = try Data(contentsOf: pathComponent)
        var items = try jsonDecoder.decode([Contact].self, from: data)
        
        let newContact = Contact.init(recordId: UUID().uuidString, firstName: contact.firstName, lastName: contact.lastName, phone: contact.phone)
        
        items.append(newContact)
        
        let jsonCodedData = try jsonEncoder.encode(items)
        try jsonCodedData.write(to: pathComponent)
        print("element has been added!")
        
        
    }
   
    
    func delete(contact: Contact) throws {
        fatalError("unimplemented")
    }
    
    func update(contact: Contact) throws {
        fatalError("unimplemented")
    }
}
