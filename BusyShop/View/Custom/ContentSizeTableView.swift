//
//  ContentSizeTableView.swift
//  BusyShop
//
//  Created by Mike Kihiu on 28/10/2022.
//

import UIKit

class ContentSizeTableView: UITableView {

    override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: contentSize.width, height: contentSize.height)
    }
}
