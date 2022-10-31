//
//  HomeView.swift
//  BusyShop
//
//  Created by Mike Kihiu on 27/10/2022.
//

import UIKit

class ReceiptScene: UIViewController {
    
    @IBOutlet weak var table: ContentSizeTableView!
    @IBOutlet weak var totalLabel: UILabel!
    
    var viewModel: ReceiptViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        
        totalLabel.text = "\(viewModel?.total ?? 0.0)"
    }
    
    @IBAction func tappedShare(_ sender: Any) {
        if let shareMessage = viewModel?.shareMessage {
            let shareSheet = UIActivityViewController(activityItems: [shareMessage], applicationActivities: nil)
            present(shareSheet, animated: true)
        }
    }
}

extension ReceiptScene: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiptCell"),
              let fruit = viewModel?.items[indexPath.row] else { return UITableViewCell() }
        cell.textLabel?.text = "\(fruit.count) x \(fruit.name ?? "")"
        cell.detailTextLabel?.text = "\(fruit.totalPrice)"
        return cell
    }
}
