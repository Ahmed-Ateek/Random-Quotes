//
//  Constant.swift
//  ImageSliderMVP
//
//  Created by Ateek on 5/30/20.
//  Copyright © 2020 Ateek. All rights reserved.
//

import Foundation
//Typealias
typealias CompletionHandler<T:Decodable> = (_ error:String?,_ code:Int?,T?)->()


// URLS
let BASE_URL = "https://programming-quotes-api.herokuapp.com/"

 let GET_QUOTES = "\(BASE_URL)quotes/page/"
