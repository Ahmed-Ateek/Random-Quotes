//
//  PresenterFavorites.swift
//  Random Quote
//
//  Created by Esar Tech on 6/26/20.
//  Copyright © 2020 Ahmed-Ateek. All rights reserved.
//

import Foundation
import UIKit
import CoreData
@available(iOS 13.0, *)
class PresenterFavorites {
    private var favoritQuotes: [NSManagedObject] = []
    init() {}
    
    
    func fetchData() {
          guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
              return
          }
          
          let managedContext = appDelegate.persistentContainer.viewContext
          
          let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
          
          do {
              favoritQuotes = try managedContext.fetch(fetchRequest)
          } catch let error as NSError {
              print("Could not fetch. \(error), \(error.userInfo)")
          }
    }
    func sendCountToTableView() -> Int {
        return favoritQuotes.count
    }
    // Here Passing Data to Cell
    func configureQuotesCell(cell:FetchQoutesCell,index:Int){
        cell.displayAuthor(authorName:favoritQuotes[index].value(forKey: "authorName") as! String  )
        cell.displayQoutes(qoutes: favoritQuotes[index].value(forKey: "quotes") as! String )
    }
    
    
}
