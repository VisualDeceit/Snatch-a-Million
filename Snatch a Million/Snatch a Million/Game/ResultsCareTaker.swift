//
//  ResultsCareTaker.swift
//  Snatch a Million
//
//  Created by Alexander Fomin on 04.04.2021.
//

import Foundation

enum UserDefaultsKeys {
    static let results = "results"
}

class ResultsCareTaker {
    
    func save(_ records: [Result]) {
        do {
            let memento = try JSONEncoder().encode(records)
            UserDefaults.standard.set(memento, forKey: UserDefaultsKeys.results)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func load() -> [Result] {
        guard let memento = UserDefaults.standard.value(forKey: UserDefaultsKeys.results) as? Data  else {
           return []
        }
        return (try? JSONDecoder().decode([Result].self, from: memento)) ?? []
    }
}
