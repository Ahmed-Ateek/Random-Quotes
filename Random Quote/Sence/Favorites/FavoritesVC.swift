//
//  FavoritesVC.swift
//  Random Quote
//
//  Created by Esar Tech on 6/26/20.
//  Copyright © 2020 Ahmed-Ateek. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class FavoritesVC: UIViewController {
    @IBOutlet weak var favoriteTable:UITableView!
    var presenter: PresenterFavorites!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = PresenterFavorites()
        setupView()
    }
    



}
@available(iOS 13.0, *)
extension FavoritesVC{
    private func setupView(){
        presenter = PresenterFavorites()
        presenter.fetchData()
        favoriteTable.delegate = self
        favoriteTable.dataSource = self
        favoriteTable.register(UINib(nibName: "FetchQoutesCell", bundle: nil), forCellReuseIdentifier: "FetchQoutesCell")
        favoriteTable.reloadData()
           navigationController?.navigationBar.prefersLargeTitles = false
    }
}
@available(iOS 13.0, *)
extension FavoritesVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.sendCountToTableView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FetchQoutesCell", for: indexPath) as? FetchQoutesCell{
            presenter.configureQuotesCell(cell: cell, index: indexPath.row)
            return cell
        }else{
            return UITableViewCell()
        }
    }
   
}
