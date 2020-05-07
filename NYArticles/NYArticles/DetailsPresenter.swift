//
//  DetailsPresenter.swift
//  NYArticles
//
//  Created by Anna Vorobiova on 06.05.2020.
//  Copyright © 2020 Anna Vorobiova. All rights reserved.
//

import Foundation

class DetailsPresenter {
    private weak var detailsViewController: DetailsViewController?
    
    init(viewController: DetailsViewController) {
        detailsViewController = viewController
    }
}
