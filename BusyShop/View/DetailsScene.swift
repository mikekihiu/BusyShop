//
//  DetailsScene.swift
//  BusyShop
//
//  Created by Mike Kihiu on 28/10/2022.
//

import UIKit
import SDWebImage

class DetailsScene: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var viewModel: DetailsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let viewModel = viewModel else { return }
        imageView.sd_setImage(with: viewModel.imageRef, placeholderImage: UIImage(systemName: "photo.on.rectangle"))
        nameLabel.text = viewModel.item.name
        priceLabel.text = "Price \(viewModel.item.price)"
    }
}
