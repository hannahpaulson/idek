//
//  RedditService.swift
//  idek
//
//  Created by Hannah Paulson on 16/12/2018.
//  Copyright © 2018 Hannah Paulson. All rights reserved.
//

import Foundation

class RedditService {
    
    static let shared = RedditService()
    
    public func loadRedditData(completion: @escaping (_ result: Bool, _ redditPosts: [RedditPost])->()) {
        let url = URL(string: "https://www.reddit.com/r/aww/top.json?limit=100")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let jsonObject = try? JSONSerialization.jsonObject(with: data!, options: []),
                let redditJson = jsonObject as? [String: AnyObject],
                let firstData = redditJson["data"] as? [String: AnyObject],
                let childrenData = firstData["children"] as? [[String: AnyObject]]  else {
                    completion(false, [])
                    return
            }
            
            let posts = childrenData.compactMap({ children -> RedditPost? in
                guard let postData = children["data"] as? [String: AnyObject] else {
                    return nil
                }
                return RedditPost.from(postData)
            })
            completion(true, posts)
        }
        task.resume()
    }
}
