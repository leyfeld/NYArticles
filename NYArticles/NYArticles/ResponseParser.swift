//
//  ResponseParser.swift
//  NYArticles
//
//  Created by Anna Vorobiova on 07.05.2020.
//  Copyright © 2020 Anna Vorobiova. All rights reserved.
//

import Foundation

class ResponseParser {
    
    class func getArticles(response: [String: Any]) -> [Article] {
        let results = response["results"] as! [[String:Any]]
        var articles: [Article] = []
        for info in results {
            let title = info["title"] as! String
            let abstract = info["abstract"] as! String
            let author = info["byline"] as! String
            let section = info["section"] as! String
            let date = info["published_date"] as! String
            let url = info["url"] as! String
            let article = Article(title: title, author: author, section: section, abstract: abstract, date: date, url: url)
            print(article)
            articles.append(article)
            
        }
        print(results)
        return articles
    }
}

//struct Article {
//    public var title: String
//    public var author: String
//    public var image: UIImage
//    public var section: String
//    public var abstract: String
//    public var date: String
//    public var url: String
//}
