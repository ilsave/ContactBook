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


extension HardcodedRepo: CallHistoryRepository {
    
    func getHistory() throws -> [CallRecord] {
        return records
    }
    
    func add(record: CallRecord) throws {
        records.append(record)
    }
    
    
}
