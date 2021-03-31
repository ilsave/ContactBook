//
//  HardcoredRepo.swift
//  ContactBookFinal
//
//  Created by Gushchin Ilya on 31.03.2021.
//

import Foundation

class HardcodedRepo {
    private var records: [CallRecord] = []
}

extension HardcodedRepo: ContactsRepository {
    func getContacts() throws -> [Contact] {
        return [
            Contact(recordId: "1", firstName: "1", lastName: "", phone: "1234567890"),
            Contact(recordId: "2", firstName: "2", lastName: "", phone: "657686433"),
            Contact(recordId: "3", firstName: "3", lastName: "", phone: "432563"),
            Contact(recordId: "4", firstName: "4", lastName: "", phone: "8756765"),
        ]
    }
    
    func add(contact: ContactsData) throws {
        fatalError("unimplemented")
    }
    
    func delete(contact: Contact) throws {
        fatalError("unimplemented")
    }
    
    func update(contact: Contact) throws {
        fatalError("unimplemented")
    }
}
