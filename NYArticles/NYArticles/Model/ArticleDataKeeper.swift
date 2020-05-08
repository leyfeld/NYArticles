//
//  ArticleDataKeeper.swift
//  NYArticles
//
//  Created by Anna Vorobiova on 07.05.2020.
//  Copyright © 2020 Anna Vorobiova. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ArticleDataKeeper {
    
    public func getArticlesFromCoreData() -> [Article] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return []}
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Articles")
        var articles: [Article] = []
        do {
            let result = try context.fetch(request)
            for newData in result as! [NSManagedObject] {
                guard let data = newData.value(forKey: "article") as? Data else {continue}
                guard let article = try? JSONDecoder().decode(Article.self, from:data) else {continue}
                articles.append(article)
            }
        } catch {
            print("Failed fetching")
        }
        return articles
    }
    
    public func saveArticleToCoreData(article: Article) {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let context = appDelegate.persistentContainer.viewContext
            
        guard let entity = NSEntityDescription.entity(forEntityName: "Articles", in: context) else {return}
            let newArticle = NSManagedObject(entity: entity, insertInto: context)
            
            let jsonEncoder = JSONEncoder()
            guard let articleData = try? jsonEncoder.encode(article) else {return}
            newArticle.setValue(articleData, forKey: "article")
            do {
                try context.save()
            } catch {
                print("Failed saving")
            }
    }
    
    public func removeArticle(indexArticle: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Articles")
        do {
            let objects = try context.fetch(request)
            context.delete(objects[indexArticle] as! NSManagedObject)
            try context.save()
        } catch _ {
            print("Failed removing")
        }
    }
}
