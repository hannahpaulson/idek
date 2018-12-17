//
//  idekTests.swift
//  idekTests
//
//  Created by Hannah Paulson on 16/12/2018.
//  Copyright © 2018 Hannah Paulson. All rights reserved.
//

import XCTest
import Foundation
@testable import idek

class idekTests: XCTestCase {
    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetsAListOfRedditPosts() {
        let expect = expectation(description: "Test")
        loadRedditData(){ result,posts  in
            XCTAssert(result)
            XCTAssertEqual(posts.count, 1)
            XCTAssertEqual(posts.first!.title, "Do you think we need a DNA test?")
            expect.fulfill()
        }
        waitForExpectations(timeout: 60) { error in
            XCTAssertNil(error)
        }
    }
    
    func loadRedditData(completion: @escaping (_ result: Bool, _ redditPosts: [RedditPost])->()) {
        let url = URL(string: "https://www.reddit.com/r/aww/top.json?limit=1")!
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

    func testGetPostData() {
        let expect = expectation(description: "Test")
        loadRedditData(){ result,posts  in
            XCTAssert(result)
            XCTAssertEqual(posts.count, 1)
            XCTAssertEqual(posts.first!.title, "Do you think we need a DNA test?")
            expect.fulfill()
        }
        waitForExpectations(timeout: 60) { error in
            XCTAssertNil(error)
        }
    }
    
    func loadRedditData(completion: @escaping (_ result: Bool, _ redditPosts: [RedditPost])->()) {
        let url = URL(string: "https://www.reddit.com/r/aww/top.json?limit=1")!
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
