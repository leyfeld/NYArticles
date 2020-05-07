//
//  ServiceAPIManager.swift
//  NYArticles
//
//  Created by Anna Vorobiova on 07.05.2020.
//  Copyright © 2020 Anna Vorobiova. All rights reserved.
//

import Foundation

class ServiceAPIManager {
    
    private let httpClient: HttpClient
    
    init(){
        httpClient = HttpClient()
    }
    
    public func getMostViewedArticles(onComplete: @escaping (Dictionary<String, Any>?, Error?) -> Void) {
        httpClient.request(url: "https://api.nytimes.com/svc/mostpopular/v2/viewed/30.json?api-key=VukXlpqJIrfhow6RpdAVbWIrHdkLHTyB", onComplete: {response, error in onComplete(response,error)})
    }
    
    public func getMostSharedArticles(onComplete: @escaping ([Article]?, Error?) -> Void) {
        httpClient.request(url: "https://api.nytimes.com/svc/mostpopular/v2/shared/30.json?api-key=VukXlpqJIrfhow6RpdAVbWIrHdkLHTyB", onComplete: {response, error in
            let articles = ResponseParser.getArticles(response: response ?? ["":""])
            onComplete(articles,error)
            
        })
    }
    
    public func getMostEmailedArticles(onComplete: @escaping (Dictionary<String, Any>?, Error?) -> Void) {
        httpClient.request(url: "https://api.nytimes.com/svc/mostpopular/v2/emailed/30.json?api-key=VukXlpqJIrfhow6RpdAVbWIrHdkLHTyB", onComplete: {response, error in onComplete(response,error)})
    }
}
