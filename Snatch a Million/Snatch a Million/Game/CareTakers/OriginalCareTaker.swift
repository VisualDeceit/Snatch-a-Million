//
//  OriginalCareTaker.swift
//  Snatch a Million
//
//  Created by Alexander Fomin on 10.04.2021.
//

import Foundation

enum UserDefaultsKeys {
    static let results = "results"
    static let questions = "questions"
}


class OriginalCareTaker {
    let key: String
    
    init(key: String) {
        self.key = key
    }
    
    func save<T: Codable>(_ object: [T]) {
        do {
            let memento = try JSONEncoder().encode(object)
            UserDefaults.standard.set(memento, forKey: key)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func load<T: Codable>() -> [T] {
        guard let memento = UserDefaults.standard.value(forKey:key) as? Data  else { return [] }
        return (try? JSONDecoder().decode([T].self, from: memento)) ?? []
    }
}
