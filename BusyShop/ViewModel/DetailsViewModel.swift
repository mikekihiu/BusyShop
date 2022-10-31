//
//  DetailsViewModel.swift
//  BusyShop
//
//  Created by Mike Kihiu on 28/10/2022.
//

import Foundation
import FirebaseStorageUI

struct DetailsViewModel {
    let item: ScannedFruit
    let ref = Storage.storage(url: "gs://the-busy-shop.appspot.com").reference()
    
    var imageRef: StorageReference {
        ref.child(item.image)
    }
}
