//
//  HackerNewsService.swift
//  ParseStarterProject-Swift
//
//  Created by Tao Liu on 9/1/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Alamofire

class HackerNewsService: NSObject {
    let itemBaseURL = "https://hacker-news.firebaseio.com/v0/item"
    let topStoryURl = "https://hacker-news.firebaseio.com/v0/topstories.json"
    
    func getStories(){
        Alamofire.request(.GET,topStoryURl).responseJSON(){
            (_, _, data, _) in
            
            let story = JSON(data!)
            let num = story[0]
            //println()
        }
    
    }
   
}


