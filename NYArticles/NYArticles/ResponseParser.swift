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
            guard let image = getImage(newArticle) else { continue }
            let article = Article(title: title, author: author, image: image, section: section, abstract: abstract, date: date, url: url)
            print(article)
            articles.append(article)
        }
        print(results)
        return articles
    }
    
    class private func getImage(_ newArticle: [String:Any]) -> UIImage? {
        guard let media = newArticle["media"] as? [[String:Any]] else { return #imageLiteral(resourceName: "article") }
        if media.count == 0{
            return #imageLiteral(resourceName: "article")
        }
        guard let metadata = media[0]["media-metadata"] as? [[String:Any]] else { return #imageLiteral(resourceName: "article") }
        guard let url = metadata[2]["url"] as? String else { return #imageLiteral(resourceName: "article") }
        if let imageUrl = URL(string: url) {
            if let data = try? Data(contentsOf: imageUrl) {
                return UIImage(data: data)
            }
        }
        return #imageLiteral(resourceName: "article")
    }
}
