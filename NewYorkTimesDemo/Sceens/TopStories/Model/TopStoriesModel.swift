//
//  TopStoriesModel.swift
//  NewYorkTimesDemo
//
//  Created by Zhaoyang Li on 10/31/20.
//

import UIKit

struct Result: Decodable {
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case abstract = "abstract"
        case urlString = "url"
        case imageString = "thumbnail_standard"
        case timeString = "updated_date"
    }
    
    var title: String?
    var abstract: String?
    var urlString: String?
    var imageString: String?
    var timeString: String?
}

struct ResultsHolder: Decodable {
    var results: [Result]?
}

class ValidStory {
    var thumbImage: UIImage
    var title: String
    var time: String
    var url: URL
    var abstract: String
    
    init(thumbImage: UIImage, title: String, time: String, url: URL, abstract: String) {
        self.thumbImage = thumbImage
        self.title = title
        self.time = time
        self.url = url
        self.abstract = abstract
    }
}
