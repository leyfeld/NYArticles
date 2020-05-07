//
//  ArticlesPresenter.swift
//  NYArticles
//
//  Created by Anna Vorobiova on 06.05.2020.
//  Copyright © 2020 Anna Vorobiova. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ArticlesPresenter {
    
    private weak var articlesViewController: ArticlesViewController?
    private var articles: [Article] = []
    private var favoritesArticles: [Article] = []
    private let service = ServiceAPIManager()
    
    init(viewController: ArticlesViewController?) {
        articlesViewController = viewController
        getArticles(type: ArticlesBarItem.viewed)
    }
    
    public func changeBarItem(_ newItem: ArticlesBarItem) {
        self.changeHeader(newHeader: newItem.rawValue)
        if newItem == ArticlesBarItem.favorites {
            articles = ArticleDataKeeper().getArticlesFromCoreData()
            self.setArticlesForTable()
        }
        else {
            self.getArticles(type: newItem)
        }
    }
    
    public func changeHeader(newHeader: String) {
        articlesViewController?.setHeader(newHeader)
    }
    
    public func didSelectArticle(_ indexArticle: Int) {
        let selectedArticle = articles[indexArticle]
        let details = [selectedArticle.author, selectedArticle.section, selectedArticle.abstract, selectedArticle.date, selectedArticle.url]
        if let viewController = articlesViewController?.storyboard?.instantiateViewController(identifier: "DetailsViewController") as? DetailsViewController {
            var image: UIImage? = #imageLiteral(resourceName: "article")
            if let imageUrl = URL(string: selectedArticle.imageUrl) {
                if let data = try? Data(contentsOf: imageUrl) {
                    image = UIImage(data: data)
                }
            }
            viewController.newImage = image
            viewController.text = selectedArticle.title
            viewController.articleDetails = details
            articlesViewController?.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    public func saveArticleToFavorites(indexArticle: Int) {
        let selectedArticle = articles[indexArticle]
        ArticleDataKeeper().saveArticleToCoreData(article: selectedArticle)
    }
    
    public func removeFavoriteArticle(indexArticle: Int) {
        ArticleDataKeeper().removeArticle(indexArticle: indexArticle)
    }
    
    private func getArticles(type: ArticlesBarItem){
        DispatchQueue.global().async {
            self.service.getArticles(type: type, onComplete: { newArticles, error in
                if let unwrappedArticles = newArticles{
                    self.articles = unwrappedArticles
                    self.setArticlesForTable()
                }
            })
        }
    }
    
    private func setArticlesForTable() {
        let titles = articles.map{$0.title}
        DispatchQueue.main.async {
            self.articlesViewController?.setArticles(titles)
        }
    }
}
