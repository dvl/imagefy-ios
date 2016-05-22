//
//  BaseService.swift
//  imagefy
//
//  Created by Guilherme Augusto on 21/05/16.
//  Copyright © 2016 Alan M. Lira. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

public typealias RequestBlockCompletion = (JSON?, NSError?) -> Void

public let requestLimit = 20

class BaseService: NSObject {
    
    private let apiVersion = "v1"
    private let host       = "http://imagefy.herokuapp.com/api"
    
    func get(path:String, offset: Int? = 0, parameters: [String: AnyObject]? = nil, requestBlockCompletion: RequestBlockCompletion) {
        
        let url = path.beginsWith("http") ? path : "\(host)/\(apiVersion)/\(path)"
        
        Alamofire.request(.GET, url, parameters: parameters)
            .responseJSON { response in
                
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        requestBlockCompletion(json, nil)
                    }
                case .Failure(let error):
                    requestBlockCompletion(nil, error)
                }
        }
    }
    
    func post(path: String, parameters: [String: AnyObject]? = nil, requestBlockCompletion: RequestBlockCompletion) {
        
        let url = path.beginsWith("http") ? path : "\(host)/\(apiVersion)/\(path)"
        
        Alamofire.request(.POST, url, parameters: parameters)
            .responseJSON { response in
                
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        requestBlockCompletion(json, nil)
                    }
                case .Failure(let error):
                    requestBlockCompletion(nil, error)
                }
        }
    }
}