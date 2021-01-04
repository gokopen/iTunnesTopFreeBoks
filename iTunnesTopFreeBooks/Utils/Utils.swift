//
//  Utils.swift
//  iTunnesTopFreeBooks
//
//  Created by Gokhan Alp on 3.01.2021.
//

import UIKit

class Utils {
    static func getNibViewController<V: UIViewController>(type: V.Type) -> V {
        let name = String(describing: V.self)
        let bundle = Bundle(for: V.self)
        let vc = V(nibName: name, bundle: bundle)
        return vc
    }
    
    static func stringToDate(string: String?) -> Date? {
        if let safeSTR = string {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let date = formatter.date(from: safeSTR)
            return date
        } else {
            return nil
        }
    }
    
    static func dateToStringTRFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-YYYY"
        let string = formatter.string(from: date)
        return string
    }
}
