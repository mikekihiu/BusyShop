//
//  ReceiptViewModel.swift
//  BusyShop
//
//  Created by Mike Kihiu on 28/10/2022.
//

import Foundation

struct ReceiptViewModel {
    let items: [ScannedFruit]
    
    var total: Float {
        var sum = Float(0)
        for item in items {
            sum += item.totalPrice
        }
        return sum
    }
    
    var shareMessage: String {
        var message = ""
        for item in items {
           message = "\(message)\(item.count) x \(item.name ?? "") \(item.totalPrice)\n"
        }
        message = "\(message)Total \(total)\n\(orderTime)"
        return message
    }
    
    var orderTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        return dateFormatter.string(from: Date())
    }
}
