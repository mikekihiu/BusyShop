//
//  String+.swift
//  BusyShop
//
//  Created by Mike Kihiu on 31/10/2022.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
