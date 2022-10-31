//
//  BusyShopTests.swift
//  BusyShopTests
//
//  Created by Mike Kihiu on 27/10/2022.
//

import XCTest
@testable import BusyShop

final class BusyShopTests: XCTestCase {

    func testCartLogic() {
        let viewModel = CartViewModel()
        viewModel.dbFruits = [
            "APL883": ["description": "Apple", "image": "apple.jpg", "price": Float(5.0)],
            "COC378": ["description": "Coconut", "image": "coconut.jpg", "price": Float(14.0)],
        ]
        
        viewModel.addScannedFruit("") { }
        XCTAssert(viewModel.scannedFruitsKeys.isEmpty, "Invalid product id ignored")
        
        viewModel.addScannedFruit("APL883") { }
        XCTAssert(viewModel.scannedFruitsKeys.count == 1, "New product added")
        
        viewModel.addScannedFruit("APL883") { }
        XCTAssert(viewModel.scannedFruitsKeys.count == 1, "Item not duplicated in cart")
        XCTAssert(viewModel.scannedFruits["Apple"]?.count == 2, "Count incremented when duplicate item scanned")
        
        viewModel.addScannedFruit("COC378") { }
        XCTAssert(viewModel.scannedFruitsKeys.count == 2, "Different product added")
    }
}
