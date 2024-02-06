//
//  UserDefalutManager.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/24/24.
//

import UIKit

class UserDefalutsManager {
    
    static let shared = UserDefalutsManager()
    
    private init() {}
    
    let ud = UserDefaults.standard
    
    func removeAllUserDefalts() {
        for key in ud.dictionaryRepresentation().keys {
            ud.removeObject(forKey: key.description)
        }
    }
}
