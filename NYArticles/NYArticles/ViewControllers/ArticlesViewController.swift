//
//  ArticlesTableViewController.swift
//  NYArticles
//
//  Created by Anna Vorobiova on 06.05.2020.
//  Copyright © 2020 Anna Vorobiova. All rights reserved.
//

import UIKit

class ArticlesViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource, UITabBarDelegate {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var header: UINavigationItem!
    @IBOutlet weak var articlesTabBar: UITabBar!
    @IBOutlet weak var articlesTable: UITableView!
    
    private var articlesPresenter: ArticlesPresenter?
    private var articles: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        articlesTabBar.selectedItem = articlesTabBar.items?.first
        articlesPresenter = ArticlesPresenter(viewController: self)
        self.startSpinner()
    }

    public func setPresenter(_ presenter: ArticlesPresenter) {
        articlesPresenter = presenter
    }
    
    public func setHeader(_ newHeader: String) {
        header.title = newHeader
    }
    
    public func setArticles(_ newArticles: [String]) {
        articles = newArticles
        self.stopSpinner()
        articlesTable.reloadData()
    }
    
    private func stopSpinner() {
        spinner.stopAnimating()
        spinner.isHidden = true
    }
    
    private func startSpinner() {
        spinner.startAnimating()
        spinner.isHidden = false
    }
    
    private func clearTable() {
        articles = []
        articlesTable.reloadData()
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.clearTable()
        self.startSpinner()
        guard let articlesBarItem = ArticlesBarItem(rawValue: item.title ?? "") else {return}
        articlesPresenter?.changeBarItem(articlesBarItem)
    }
    
    // MARK: - Table view data source

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articlesCell", for: indexPath) as! ArticlesTableViewCell

        cell.title.text = articles[indexPath.row]
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        articlesPresenter?.didSelectArticle(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

     func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if articlesTabBar.selectedItem == articlesTabBar.items?.last {
            let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
                self.articles.remove(at: indexPath.row)
                tableView.reloadData()
                self.articlesPresenter?.removeFavoriteArticle(indexArticle: indexPath.row)
            })
            return [deleteAction]
        }
        
        let editAction = UITableViewRowAction(style: .default, title: "Favorites", handler: { (action, indexPath) in
            self.articlesPresenter?.saveArticleToFavorites(indexArticle: indexPath.row)
        })
        editAction.backgroundColor = .magenta
        
        
        return [editAction]
    }
}

enum ArticlesBarItem: String {
    case viewed = "Most Viewed"
    case shared = "Most Shared"
    case emailed = "Most Emailed"
    case favorites = "Favorites"
}

struct Article : Codable {
     var title: String
     var author: String
     var imageUrl: String
     var section: String
     var abstract: String
     var date: String
     var url: String
}
