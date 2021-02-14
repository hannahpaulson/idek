//
//  RedditPostDetails.swift
//  idek
//
//  Created by Hannah Paulson on 17/12/2018.
//  Copyright © 2018 Hannah Paulson. All rights reserved.
//

import Foundation

class RedditPostDetails {
    
    let title: String
    let subreddit: String
    let author: String
    let time: Int
    let thumbNail: String
    let permalink: String
    
    public init(title: String,
                subreddit: String,
                author: String,
                time: Int,
                thumbNail:String,
                permalink: String) {
        self.title = title
        self.subreddit = subreddit
        self.author = author
        self.time = time
        self.thumbNail = thumbNail
        self.permalink = permalink
    }
    
    
    public static func from(_ json: [String: Any]) -> RedditPostDetails? {
        
        guard let title = json["title"] as? String,
            let subreddit = json["subreddit"] as? String,
            let author = json["author"] as? String,
            let time = json["created"] as? Int,
            let permalink = json["permalink"] as? String,
            let thumbNail = json["thumbnail"] as? String else {
                return nil
        }
        
        return RedditPostDetails(title: title,
                          subreddit: subreddit,
                          author: author,
                          time: time,
                          thumbNail: thumbNail,
                          permalink:permalink)
    }
}
