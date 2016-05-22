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
    
    private class func header() -> [String: String] {
        var headers = [String: String]()
        headers["cache-control"] = "no-cache"
        
        if let key = NSUserDefaults.standardUserDefaults().stringForKey("TokenKey") {
            headers["Authorization"] = "Token \(key)"
        }
        
        return headers
    }
    
    
    func get(path:String, offset: Int? = 0, parameters: [String: AnyObject]? = nil, requestBlockCompletion: RequestBlockCompletion) {
        
        let url = path.beginsWith("http") ? path : "\(host)/\(apiVersion)/\(path)"
        
        var headers: [String: String] = ["cache-control": "no-cache"]
        
        if let key = NSUserDefaults.standardUserDefaults().stringForKey("TokenKey") {
            headers["Authorization"] = "Token \(key)"
        }
        
        Alamofire.request(.GET, url, parameters: parameters, headers: headers)
            .validate(statusCode: 200..<300)
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
        
        let headers = [
            "content-type": "application/json",
            "cache-control": "no-cache"
        ]
        
        Alamofire.request(.POST, url, parameters: parameters, encoding: .JSON, headers: headers)
            .validate(statusCode: 200..<300)
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
    
    func upload(path: String, image: UIImage, parameters: [String: AnyObject]? = nil, requestBlockCompletion: RequestBlockCompletion) {
        
        let url = path.beginsWith("http") ? path : "\(host)/\(apiVersion)/\(path)"
        
        var headers = BaseService.header()
        headers["content-type"] = "multipart/form-data"
        
        Alamofire.upload(.POST, url, headers: headers, multipartFormData: { (multipartFormData) in
            if let img = UIImageJPEGRepresentation(image, 0.5) {
                multipartFormData.appendBodyPart(data: img, name: "photo", fileName: "file.png", mimeType: "image/png")
            }
            
            if let params = parameters {
                
                for (key, value) in params {
                    if value is Bool {
                        multipartFormData.appendBodyPart(data: "\(value)".dataUsingEncoding(NSUTF8StringEncoding)!, name: key)
                        continue
                    }
                    
                    multipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: key)
                }
            }
            
        }) { (encondingResult) in
            switch encondingResult {
            case .Success(let upload, _, _):
                upload.validate(statusCode: 200..<300)
                    .validate(contentType: ["application/json"])
                    .response { response in
                        requestBlockCompletion(nil, nil)
                }
            case .Failure(let error):
                requestBlockCompletion(nil, NSError(domain: "\(error)", code: -1000, userInfo: nil))
            }
        }
        
    }
}