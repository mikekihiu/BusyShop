//
//  HomeViewModel.swift
//  BusyShop
//
//  Created by Mike Kihiu on 27/10/2022.
//

import Foundation
import FirebaseDatabase

class CartViewModel {
    
    var dbFruits: [String: Any]?
    var scannedFruits: [String: ScannedFruit] = [:]
    var scannedFruitsKeys: [String] = []
    var selectedRow: Int?
    
    init() {
        let ref = Database.database().reference()

        ref.observe(DataEventType.value) { [weak self] snapshot in
            self?.dbFruits = snapshot.value as? [String: Any]
        }
    }
    
    func addScannedFruit(_ fruitId: String, _ completion: () -> Void) {
        guard let fruit = dbFruits?[fruitId] as? [String: Any],
              let fruitName = fruit["description"] as? String,
              let price = fruit["price"] as? Float,
              let image = fruit["image"] as? String else { return }
        let newScan = ScannedFruit(count: 1, price: price, image: image)
        if let existingScan = scannedFruits[fruitName] {
            let newCount = existingScan.count + 1
            scannedFruits[fruitName]?.count = newCount
        } else {
            scannedFruits[fruitName] = newScan
            scannedFruitsKeys.append(fruitName)
        }
        completion()
    }
    
    var receiptViewModel: ReceiptViewModel {
        var items: [ScannedFruit] = []
        for (name, fruit) in scannedFruits {
            var tempFruit = fruit
            tempFruit.name = name
            items.append(tempFruit)
        }
        return ReceiptViewModel(items: items)
    }
    
    var detailsViewModel: DetailsViewModel? {
        guard let selectedRow = selectedRow,
              let temp = scannedFruits[scannedFruitsKeys[selectedRow]] else { return nil }
        var item = temp
        item.name = scannedFruitsKeys[selectedRow]
        return DetailsViewModel(item: item)
    }
}
