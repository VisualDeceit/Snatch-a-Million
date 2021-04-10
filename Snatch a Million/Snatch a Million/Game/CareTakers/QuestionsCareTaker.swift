//
//  QuestionsCareTaker.swift
//  Snatch a Million
//
//  Created by Alexander Fomin on 10.04.2021.
//

import Foundation

class QuestionsCareTaker {
    
    func save(_ questions: [Question]) {
        do {
            let memento = try JSONEncoder().encode(questions)
            UserDefaults.standard.set(memento, forKey: UserDefaultsKeys.questions)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func load() -> [Question] {
        guard let memento = UserDefaults.standard.value(forKey: UserDefaultsKeys.questions) as? Data  else {
           return []
        }
        return (try? JSONDecoder().decode([Question].self, from: memento)) ?? []
    }
}
