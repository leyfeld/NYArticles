//
//  DetailsViewController.swift
//  NYArticles
//
//  Created by Anna Vorobiova on 06.05.2020.
//  Copyright © 2020 Anna Vorobiova. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var articleTitle: UILabel!
    
    public var text: String = ""
    private var detailsPresenter: DetailsPresenter?
    private let detailsType: [String] = ["Author", "Section", "Abstract", "Date", "Url"]
    private var articleDetails: [String] = ["By Sanya Dosani and Adam Westbrook","Opinion","A look at the style of Dr. Amy Acton, who has earned praise for her daily briefings on the pandemic.", "2020-05-05", "https://www.nytimes.com/2020/05/05/opinion/coronavirus-ohio-amy-acton.html"]
    override func viewDidLoad() {
        super.viewDidLoad()

        self.detailsPresenter = DetailsPresenter(viewController: self)
        // Do any additional setup after loading the view.
        articleTitle.text = text
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailsType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailsCell", for: indexPath) as! DetailsTableViewCell
        cell.type.text = detailsType[indexPath.row]
        cell.value.text = articleDetails[indexPath.row]
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
