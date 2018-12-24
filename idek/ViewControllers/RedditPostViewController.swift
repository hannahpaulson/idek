//
//  RedditPostViewController.swift
//  idek
//
//  Created by Hannah Paulson on 17/12/2018.
//  Copyright © 2018 Hannah Paulson. All rights reserved.
//

import Foundation
import UIKit

class RedditPostViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var post: RedditPost!
    var commentArray = [RedditPostComments]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 600
        
        RedditService.shared.loadPostDetailData(post: post.permalink) { (Bool, post, comments) in
            self.commentArray = comments
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
    
    
class CommentViewCell: UITableViewCell {
    @IBOutlet weak var bodyText: UILabel!
}
    
extension RedditPostViewController {
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentViewCell", for: indexPath) as! CommentViewCell
        
        let post = commentArray[indexPath.row]
        cell.bodyText.text = post.body
        //cell.authorText.text = post.author
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentArray.count
    }
}
    

