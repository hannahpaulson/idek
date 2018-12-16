//
//  SubRedditResponse.swift
//  idek
//
//  Created by Hannah Paulson on 16/12/2018.
//  Copyright © 2018 Hannah Paulson. All rights reserved.
//

import Foundation
public class RedditPost {
    
    let title: String
    let subreddit: String
    let author: String
    let time: Int
    
    public init(title: String,
                subreddit: String,
                author: String,
                time: Int) {
        self.title = title
        self.subreddit = subreddit
        self.author = author
        self.time = time
    }
    
    public static func from(_ json: [String: Any]) -> RedditPost? {
        guard let title = json["title"] as? String,
            let subreddit = json["subreddit"] as? String,
            let author = json["author"] as? String,
            let time = json["created"] as? Int else {
                return nil
        }
        
        return RedditPost(title: title,
                          subreddit: subreddit,
                          author: author,
                          time: time)
    }
}
