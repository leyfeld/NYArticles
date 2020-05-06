//
//  ArticlesTableViewController.swift
//  NYArticles
//
//  Created by Anna Vorobiova on 06.05.2020.
//  Copyright © 2020 Anna Vorobiova. All rights reserved.
//

import UIKit

class ArticlesViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource, UITabBarDelegate {
    
    @IBOutlet weak var articlesTabBar: UITabBar!
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var articlesTable: UITableView!
    
    private weak var articlesPresenter: ArticlesPresenter?
    private var articles: [String] = ["d", "dddd", "ddddd"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        articlesTabBar.selectedItem = articlesTabBar.items?.first
    }

    public func setPresenter(_ presenter: ArticlesPresenter) {
        articlesPresenter = presenter
    }
    
    public func setHeader(_ newHeader: String) {
        header.text = newHeader
    }
    
    public func setArticles(_ newArticles: [String]) {
        articles = newArticles
        articlesTable.reloadData()
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let articlesBarItem = ArticlesBarItem(rawValue: item.title ?? "") else {return}
        articlesPresenter?.changeBarItem(articlesBarItem)
    }
    
    // MARK: - Table view data source

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return articles.count
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articlesCell", for: indexPath) as! ArticlesTableViewCell

        cell.title.text = articles[indexPath.row]
        // Configure the cell...

        return cell
    }
   

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

enum ArticlesBarItem: String {
    case viewed = "Most Viewed"
    case shared = "Most Shared"
    case emailed = "Most Emailed"
    case favorites = "Favorites"
}
