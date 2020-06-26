//
//  InteractorFeatchQuotes.swift
//  Random Quote
//
//  Created by Esar Tech on 6/26/20.
//  Copyright © 2020 Ahmed-Ateek. All rights reserved.
//

import Foundation
class InteractorFetchQuotes {
    func getQuotes(page:Int,completion:@escaping CompletionHandler<[QuotesModelElement]>){
           let header = RequestComponent.sharesInstance.headerComponent([.content])
           RequestManager.sharesInstance.request(fromUrl: GET_QUOTES + "\(page)", byMethod: .get, withParameters: nil, andHeaders: header) { (error:String?, code:Int?, result:[QuotesModelElement]?) in
               guard let quotesResult = result else {
                   
                   completion("Error",ErrorsCodes.castError.rawValue,nil)
                   return
               }
               
               if error != nil {
                   completion(error,code,nil)
               }else {
                   completion(nil,code,quotesResult)
               }
               
           }
           
       }
}
