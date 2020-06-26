//
//  PresenterFetchQuotes.swift
//  Random Quote
//
//  Created by Esar Tech on 6/26/20.
//  Copyright © 2020 Ahmed-Ateek. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import Alamofire
protocol FetchQuotesView:class {
    func qoutesLoadedFine()
    func errorMessges(title:String,message:String)
    func didSelectQoute(index:Int)
    func showLoading()
    func hideLoading()
    
}
protocol FetchQoutesCellView {
    func displayAuthor(authorName:String)
    func displayQoutes(qoutes:String)
}
@available(iOS 13.0, *)
class PresenterFetchQuotes {
    private let interactor = InteractorFetchQuotes()
    weak var view:FetchQuotesView?
    private var nextPage = 1
    private var quoetsList = [QuotesModelElement]()
    private  var savedQuotes: [NSManagedObject] = []
    private let reachabilityManager = NetworkReachabilityManager()
    init(view:FetchQuotesView) {
        self.view = view
    }
    
    
    func checkInternet()  {
        if  reachabilityManager?.isReachable ?? false  {
            getQoutes()
        }else {
            fetchData()
        }
    }
    
    
    // here calling API To Bring all Quotes
    func getQoutes(){
        view?.showLoading()
        interactor.getQuotes(page:nextPage) { (error, code, resultImages) in
            if error != nil {
                self.view?.errorMessges(title: "Ops", message: "Sorry Something Wrong Happen Please Try Again...")
                return
            }
            if code == 200 {
                if self.nextPage == 1 {
                    self.quoetsList = resultImages ?? []
                    self.saveData()
                    
                }else {
                    self.quoetsList.append(contentsOf: self.quoetsList)
                      self.saveData()
                    self.view?.qoutesLoadedFine()}
            }
            self.view?.hideLoading()
        }
    }
    
    func saveInDataBase(quotes:String,author:String,entityName:String) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }

        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let entity =
            NSEntityDescription.entity(forEntityName: entityName,
                                       in: managedContext)!
        
        let quotesList = NSManagedObject(entity: entity,
                                         insertInto: managedContext)
        
        quotesList.setValue(quotes, forKeyPath: "quotes")
        quotesList.setValue(author, forKeyPath: "authorName")
        do {
            try managedContext.save()
            savedQuotes.append(quotesList)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    func saveData(){
        for quotes in quoetsList{
            saveInDataBase(quotes: quotes.en, author: quotes.author, entityName: "Qoutes")
        }
        self.view?.qoutesLoadedFine()
    }
    
    func fetchData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Qoutes")
        
        do {
            savedQuotes = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    
    // Here Passing Count to Table View
    func sendCountToTableView() -> Int {
        return savedQuotes.count
    }
    // Here Passing Data to Cell
    func configureQuotesCell(cell:FetchQoutesCell,index:Int){
        cell.displayAuthor(authorName:savedQuotes[index].value(forKey: "authorName") as! String  )
        cell.displayQoutes(qoutes: savedQuotes[index].value(forKey: "quotes") as! String )
        if index == (quoetsList.count) - 1 {
            self.nextPage += 1
            checkInternet()
        }
    }
    // Here if user Select an Qoutes
    func didSelectCell(index:Int){
        view?.didSelectQoute(index: index)
    }
    func addToFavorite(index:Int)  {
        let auother = savedQuotes[index].value(forKey: "authorName")  as! String
        let quotes = savedQuotes[index].value(forKey: "quotes") as! String
        saveInDataBase(quotes: quotes, author: auother, entityName: "Favorite")
    }
}
