//
//  StoryDetailModel.swift
//  NewYorkTimesDemo
//
//  Created by Zhaoyang Li on 10/31/20.
//

import UIKit

class ValidRestStoryDetail {
    var source: String
    var type: String
    var location: String
    var newsImage: UIImage
    var caption: String
    
    init(source: String, type: String, location: String, newsImage: UIImage, caption: String) {
        self.source = source
        self.type = type
        self.location = location
        self.newsImage = newsImage
        self.caption = caption
    }
}
