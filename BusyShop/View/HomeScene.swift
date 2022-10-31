//
//  HomeScene.swift
//  BusyShop
//
//  Created by Mike Kihiu on 27/10/2022.
//

import UIKit
import BarcodeScanner

class HomeScene: UIViewController {
    
    @IBOutlet weak var scanTable: UITableView!
    @IBOutlet weak var btnCheckOut: UIButton!
    @IBOutlet weak var tapToAddLabel: UILabel!
    
    lazy var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
        styleCheckOutButton()
    }
    
    private func setUpTableView() {
        scanTable.delegate = self
        scanTable.dataSource = self
    }
    
    private func styleCheckOutButton() {
        btnCheckOut.layer.borderColor = UIColor.systemBlue.cgColor
        btnCheckOut.layer.borderWidth = 1
        btnCheckOut.layer.cornerRadius = 8
    }

    @IBAction func tappedScan(_ sender: Any) {
        let scanScene = BarcodeScannerViewController()
        scanScene.codeDelegate = self
        scanScene.errorDelegate = self
        scanScene.dismissalDelegate = self
        present(scanScene, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "PushReceipt":
            (segue.destination as? ReceiptScene)?.viewModel = viewModel.receiptViewModel
        case "PushItemDetail":
            if let detailsViewModel = viewModel.detailsViewModel {
                (segue.destination as? DetailsScene)?.viewModel = detailsViewModel
            }
        default:
            break
        }
    }
}

extension HomeScene: BarcodeScannerCodeDelegate, BarcodeScannerErrorDelegate, BarcodeScannerDismissalDelegate {
    
    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        viewModel.addScannedFruit(code) { [weak self] in
            self?.scanTable.reloadData()
            if !(self?.tapToAddLabel.isHidden ?? true) {
                self?.tapToAddLabel.isHidden = true
                self?.btnCheckOut.isHidden = false
            }
        }
        controller.dismiss(animated: true, completion: nil)
    }
    
    func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
        debugPrint(error)
    }
    
    func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension HomeScene: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.scannedFruits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") else { return UITableViewCell() }
        let fruit = viewModel.scannedFruitsKeys[indexPath.row]
        cell.textLabel?.text = "\(viewModel.scannedFruits[fruit]?.count ?? 1) x \(fruit)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedRow = indexPath.row
        performSegue(withIdentifier: "PushItemDetail", sender: self)
    }
}

