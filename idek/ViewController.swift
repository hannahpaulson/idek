//
//  ViewController.swift
//  idek
//
//  Created by Hannah Paulson on 16/12/2018.
//  Copyright © 2018 Hannah Paulson. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var tableArray = [RedditPost]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        getTableData()
    }
    
    func getTableData() {
        RedditService.shared.loadRedditData() { bool , results in
            self.tableArray = results
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

class PostViewCell: UITableViewCell {
    
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postAuthor: UILabel!
    
}

extension ViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! PostViewCell
        
        let post = self.tableArray[indexPath.row]
        cell.postTitle.text = post.title
        cell.postAuthor.text = post.author
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "displayPostView", sender: self)
    }
}
