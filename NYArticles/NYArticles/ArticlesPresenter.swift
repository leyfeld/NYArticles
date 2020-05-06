//
//  ArticlesPresenter.swift
//  NYArticles
//
//  Created by Anna Vorobiova on 06.05.2020.
//  Copyright © 2020 Anna Vorobiova. All rights reserved.
//

import Foundation

class ArticlesPresenter {
    private var articlesViewController: ArticlesViewController?
    
    init(viewController: ArticlesViewController?) {
        articlesViewController = viewController
    }
    
    func changeBarItem(_ newItem: ArticlesBarItem) {
        self.changeHeader(newHeader: newItem.rawValue)
    }
    
    func changeHeader(newHeader: String) {
        articlesViewController?.setHeader(newHeader)
    }
}
