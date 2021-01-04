//
//  FavoritesManager.swift
//  iTunnesTopFreeBooks
//
//  Created by Gokhan Alp on 3.01.2021.
//

import Foundation

class FavoritesManager {
        
    static func getFavoirted(id: String) -> Bool {
        if let array = UserDefaults.standard.array(forKey: Constants.Keys.favoritedUserDefaultsKey) as? [String], array.firstIndex(of: id) != nil{
            return true
        } else {
            return false
        }
    }
    
    static func setFavorited(id: String, isFavorited: Bool) {
        if var array = UserDefaults.standard.array(forKey: Constants.Keys.favoritedUserDefaultsKey) as? [String] {
            let index = array.firstIndex(of: id)
            if isFavorited == false, let index = index {
                array.remove(at: index)
                UserDefaults.standard.setValue(array, forKey: Constants.Keys.favoritedUserDefaultsKey)
                NotificationCenter.default.post(name: Notification.Name(Constants.NotificationCenter.favoriteUpdated), object: nil)
            } else if isFavorited, index == nil {
                array.append(id)
                UserDefaults.standard.setValue(array, forKey: Constants.Keys.favoritedUserDefaultsKey)
                NotificationCenter.default.post(name: Notification.Name(Constants.NotificationCenter.favoriteUpdated), object: nil)
            }
        } else if isFavorited {
            let newArray: [String] = [id]
            UserDefaults.standard.setValue(newArray, forKey: Constants.Keys.favoritedUserDefaultsKey)
            NotificationCenter.default.post(name: Notification.Name(Constants.NotificationCenter.favoriteUpdated), object: nil)
        }
    }
    
    
}
