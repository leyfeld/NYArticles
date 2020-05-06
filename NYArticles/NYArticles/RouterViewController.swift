//
//  ViewManager.swift
//  NYArticles
//
//  Created by Anna Vorobiova on 06.05.2020.
//  Copyright © 2020 Anna Vorobiova. All rights reserved.
//

import Foundation
import UIKit

class RouterViewController: UIViewController {
    private var articlesViewController: ArticlesViewController? = viewController()
    private var articlesPresenter: ArticlesPresenter?
    
     override func viewDidLoad() {
        articlesPresenter = ArticlesPresenter(viewController: articlesViewController)
        if let unwrappedPresenter = articlesPresenter {
            articlesViewController?.setPresenter(unwrappedPresenter)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        if let unwrappedViewController = articlesViewController {
            self.present(unwrappedViewController, animated: true, completion: {})
        }
    }
}

func viewController() -> ArticlesViewController? {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: "ArticlesViewController") as? ArticlesViewController
    viewController?.modalPresentationStyle = .fullScreen
    return viewController
}
