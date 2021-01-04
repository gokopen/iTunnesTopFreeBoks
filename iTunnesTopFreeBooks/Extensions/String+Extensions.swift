//
//  String+Extensions.swift
//  iTunnesTopFreeBooks
//
//  Created by Gokhan Alp on 4.01.2021.
//

import Foundation

extension String {
    func localize() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
