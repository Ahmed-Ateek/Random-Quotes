//
//  ViewController.swift
//  Random Quote
//
//  Created by Esar Tech on 6/26/20.
//  Copyright © 2020 Ahmed-Ateek. All rights reserved.
//

import UIKit
import CoreData
@available(iOS 13.0, *)
class FetchQuoteVC: UIViewController {
    @IBOutlet weak var quotesTable:UITableView!
    
    var presenter:PresenterFetchQuotes!
    override func viewDidLoad() {
        super.viewDidLoad()
     setupView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         navigationController?.navigationBar.prefersLargeTitles = true
    }

}

@available(iOS 13.0, *)
extension FetchQuoteVC{
    private func setupView(){
        presenter = PresenterFetchQuotes(view: self)
        presenter.checkInternet()
        quotesTable.delegate = self
        quotesTable.dataSource = self
        quotesTable.register(UINib(nibName: "FetchQoutesCell", bundle: nil), forCellReuseIdentifier: "FetchQoutesCell")
       
    }
}
@available(iOS 13.0, *)
extension FetchQuoteVC:UITableViewDelegate,UITableViewDataSource{
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectCell(index: indexPath.row)
    }
    
    
}
@available(iOS 13.0, *)
extension FetchQuoteVC:FetchQuotesView{
    func didSelectQoute(index: Int) {
         AlertWithActions(actioTitle: "Save", title: "", message: "Are you sure you want to save it") {
            self.presenter.addToFavorite(index: index)
               }
    }
    
    func qoutesLoadedFine() {
        quotesTable.reloadData()
    }
    
    func errorMessges(title: String, message: String) {
        alertUser(title: title, message: message)
    }
    

    
    func showLoading() {
   
    }
    
    func hideLoading() {
       
    }
    
    
}
