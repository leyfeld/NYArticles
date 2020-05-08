//
//  HttpClient.swift
//  NYArticles
//
//  Created by Anna Vorobiova on 07.05.2020.
//  Copyright © 2020 Anna Vorobiova. All rights reserved.
//

import Foundation
import Alamofire

class HttpClient {
    
    
    public func request(url: String, onComplete: @escaping (Dictionary<String, Any>?, Error?) -> Void) {
        Alamofire.request(url, method: .get).response { response in
            guard let data = response.data else {
                onComplete(nil, response.error)
                return
            }
            do {
                let responseDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                onComplete(responseDictionary, response.error)
            } catch { onComplete(nil, error) }
        }
    }
}
