//
//  FavoritesViewController.swift
//  BotanyApp
//
//  Created by Gwinyai Nyatsoka on 16/9/2022.
//

import UIKit

protocol FavoritesDelegate: AnyObject {
    func reloadData()
}

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataModel.shared.selectedPlants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let plant = DataModel.shared.selectedPlants[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell") as! FavoriteTableViewCell
        cell.plantImageView.image = plant.image
        cell.plantTitleLabel.text = plant.title
        cell.delegate = self
        cell.plant = plant
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

extension FavoritesViewController: FavoritesDelegate {
    
    func reloadData() {
        NotificationCenter.default.post(name: Notification.Name(relodCollectionViewNotificationKey), object: self)
        tableView.reloadData()
    }
    
}
