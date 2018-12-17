//
//  RedditPostComments.swift
//  idek
//
//  Created by Hannah Paulson on 17/12/2018.
//  Copyright © 2018 Hannah Paulson. All rights reserved.
//

import Foundation

class RedditPostComments {
    
    let author: String
    let body: String
    let score: Int
    
    public init(author: String,
                body: String,
                score: Int) {
        self.author = author
        self.body = body
        self.score = score
    }
    
    public static func from(_ json: [String: Any]) -> RedditPostComments? {
        guard let author = json["author"] as? String,
            let body = json["body"] as? String,
            let score = json["score"] as? Int else {
                return nil
        }
        
        return RedditPostComments(author: author,
                                  body: body,
                                  score: score)
    }
}
