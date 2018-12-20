//
//  DashboardViewController.swift
//  MiPlatica
//
//  Created by Konstantin Portnov on 12/19/18.
//  Copyright © 2018 x0000ff. All rights reserved.
//

//############################################################
import UIKit

//############################################################
class DashboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //--------------------------------------------------------
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    var refreshControl: UIRefreshControl?

    //--------------------------------------------------------
    let service: RealAssetService = RealAssetService()

    var portfolio: Portfolio? = PortfolioStorage().load()
    var todayAssets: [RealAsset: RealAssetDay] = [RealAsset: RealAssetDay]()

    //--------------------------------------------------------
    // MARK: Overridden
    //--------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        addRefreshControl()
        updateTotalLabel()
    }
    
    //--------------------------------------------------------
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadAll()
    }

    //--------------------------------------------------------
    // MARK: - UI
    //--------------------------------------------------------
    func addRefreshControl() {
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self,
                                 action: #selector(DashboardViewController.handleRefresh(_:)),
                                 for: .valueChanged)
        
        self.refreshControl = refreshControl
        tableView.addSubview(refreshControl)
    }
    
    //--------------------------------------------------------
    // MARK: - Actions
    //--------------------------------------------------------
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        loadAll()
    }
    
    @IBAction func loadAll() {
        
        refreshControl?.endRefreshing()
        
        guard let portfolio = portfolio else { return }
        
        todayAssets = [RealAsset: RealAssetDay]()
        
        for asset in portfolio.assetShares {
            load(realAssetWithId: asset.realAssetId)
        }
    }
    
    //--------------------------------------------------------
    // MARK: - Logic
    //--------------------------------------------------------
    func refreshUI() {
        
        tableView.reloadData()
        updateTotalLabel()
    }
    
    //--------------------------------------------------------
    func updateTotalLabel() {
        
        totalLabel.text = "🤷🏻‍♂️"
        
        guard let portfolio = portfolio else { return }
        
        var total: Double?
        for asset in todayAssets.keys {

            guard let lastDay = todayAssets[asset] else { continue }

            guard let assetShare = portfolio.assetShares.first(where: {$0.realAssetId == asset.id}) else {
               continue
            }
            
            total = (total ?? 0) + lastDay.price * assetShare.shares
        }
        
        if let total = total {
            totalLabel.text = NumberFormatter.formatCurrency(amount: total)
        }
    }

    //--------------------------------------------------------
    // MARK: - Network
    //--------------------------------------------------------
    func load(realAssetWithId realAssetId: String) {
        
        let service = RealAssetService()
        service.load(withRealAssetId: realAssetId) { [weak self] (result) in
            
            guard let strongSelf = self else { return }

            switch result {
                
            case .success(let realAsset):
                strongSelf.didLoad(realAsset: realAsset)
                
            case .failure(let  error):
                strongSelf.loadFailed(withError: error)
            }
        }
    }
    
    //--------------------------------------------------------
    func didLoad(realAsset: RealAsset) {
        todayAssets[realAsset] = realAsset.days.last ?? nil
        refreshUI()
    }
    
    //--------------------------------------------------------
    func loadFailed(withError error: Error) {
        
        let alert = UIAlertController(title: "Error",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }

    //--------------------------------------------------------
    // MARK: Table View Methods
    //--------------------------------------------------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todayAssets.count
    }
    
    //--------------------------------------------------------
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "AssetDayCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        
        guard let assetShare = portfolio?.assetShares[indexPath.row] else { return cell }
        
        guard let (asset, day) = todayAssets.first(where: { $0.key.id == assetShare.realAssetId }) else { return cell }
        
        cell.textLabel?.text = asset.name
        cell.textLabel?.numberOfLines = 0
        
        let shares = assetShare.shares
        let assetAmount = day.price * shares
        
        var parts = [String]()
        let formattedAmount = NumberFormatter.formatCurrency(amount: assetAmount) ?? ""
        parts.append(formattedAmount)

        parts.append("Shares: \(assetShare.shares)")
        parts.append(day.date)

        cell.detailTextLabel?.text = parts.joined(separator: " | ")

        return cell
    }

    //--------------------------------------------------------
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //--------------------------------------------------------
}

//############################################################
