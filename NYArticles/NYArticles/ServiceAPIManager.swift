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
    
    public func getArticles(type:ArticlesBarItem, onComplete: @escaping ([Article]?, Error?) -> Void){
        let url: String
        switch type {
        case .viewed:
            url = "https://api.nytimes.com/svc/mostpopular/v2/viewed/30.json?api-key=VukXlpqJIrfhow6RpdAVbWIrHdkLHTyB"
        case .emailed:
            url = "https://api.nytimes.com/svc/mostpopular/v2/emailed/30.json?api-key=VukXlpqJIrfhow6RpdAVbWIrHdkLHTyB"
        case .shared:
             url = "https://api.nytimes.com/svc/mostpopular/v2/shared/30.json?api-key=VukXlpqJIrfhow6RpdAVbWIrHdkLHTyB"
        default:
            return
        }
        httpClient.request(url: url, onComplete: {response, error in
            guard let articles = ResponseParser.getArticles(response: response ?? ["":""]) else {
                onComplete(nil, error)
                return
            }
            onComplete(articles,error)
        })
    }
}
