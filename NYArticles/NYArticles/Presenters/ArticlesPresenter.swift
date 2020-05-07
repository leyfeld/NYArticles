//
//  ArticlesPresenter.swift
//  NYArticles
//
//  Created by Anna Vorobiova on 06.05.2020.
//  Copyright © 2020 Anna Vorobiova. All rights reserved.
//

import Foundation
import UIKit

class ArticlesPresenter {
    
    private weak var articlesViewController: ArticlesViewController?
    
    init(viewController: ArticlesViewController?) {
        articlesViewController = viewController
        let service = ServiceAPIManager()
        service.getMostSharedArticles(onComplete: {dictionary, error in
            
            self.articlesViewController?.setArticles(dictionary!)
            
        })
    }
    
    public func changeBarItem(_ newItem: ArticlesBarItem) {
        self.changeHeader(newHeader: newItem.rawValue)
    }
    
    public func changeHeader(newHeader: String) {
        articlesViewController?.setHeader(newHeader)
    }
    
    public func didSelectArticle() {
        if let viewController = articlesViewController?.storyboard?.instantiateViewController(identifier: "DetailsViewController") as? DetailsViewController {
            viewController.text = "selectedTrail"
            articlesViewController?.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
