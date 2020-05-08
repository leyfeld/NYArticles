//
//  ResponseParser.swift
//  NYArticles
//
//  Created by Anna Vorobiova on 07.05.2020.
//  Copyright © 2020 Anna Vorobiova. All rights reserved.
//

import Foundation
import UIKit

class ResponseParser {
    
    class func getArticles(response: [String: Any]) -> [Article]? {
        guard let results = response["results"] as? [[String:Any]] else { return nil }
        var articles: [Article] = []
        for newArticle in results {
            guard let title = newArticle["title"] as? String else { continue }
            guard let abstract = newArticle["abstract"] as? String else { continue }
            guard let author = newArticle["byline"] as? String else { continue }
            guard let section = newArticle["section"] as? String else { continue }
            guard let date = newArticle["published_date"] as? String else { continue }
            guard let url = newArticle["url"] as? String else { continue }
            let strImage = getImageString(newArticle)
            let article = Article(title: title, author: author, imageUrl: strImage, section: section, abstract: abstract, date: date, url: url)
            articles.append(article)
        }
        print(results)
        return articles
    }
    
    class private func getImageString(_ newArticle: [String: Any]) -> String {
        guard let media = newArticle["media"] as? [[String: Any]] else { return "" }
        if media.count == 0{
            return ""
        }
        guard let metadata = media[0]["media-metadata"] as? [[String: Any]] else { return "" }
        guard let maxObject = metadata.max(by: { (a, b) -> Bool in
            if let widthA = a["width"] as? Int, let widthB = b["width"] as? Int {
                return widthA < widthB
            }
            return false
        }) else {return ""}
        guard let strUrl = maxObject["url"] as? String else { return "" }
        return strUrl
    }
}
