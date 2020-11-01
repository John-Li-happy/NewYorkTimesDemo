//
//  TopStoriesModel.swift
//  NewYorkTimesDemo
//
//  Created by Zhaoyang Li on 10/31/20.
//

import UIKit

var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        return dateFormatter
}()

struct MultiMediaHolder: Decodable {
    var url: String?
    var caption: String?
    var copyright: String?
}

struct Result: Decodable {
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case abstract = "abstract"
        case urlString = "url"
        case imageString = "thumbnail_standard"
        case timeString = "updated_date"
        case source = "source"
        case subSection = "subsection"
        case section = "section"
        case multiMedia = "multimedia"
    }
    
    var title: String?
    var abstract: String?
    var urlString: String?
    var imageString: String?
    var timeString: String?
    var source: String?
    var subSection: String?
    var section: String?
    var multiMedia: [MultiMediaHolder]?
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
    var formattedDateAndTimeString: String? {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        guard let date = dateFormatter.date(from: time) else { return nil }
        dateFormatter.dateFormat = "MMM d, yyyy, h:mm a"
        
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
    
    init(thumbImage: UIImage, title: String, time: String, url: URL, abstract: String) {
        self.thumbImage = thumbImage
        self.title = title
        self.time = time
        self.url = url
        self.abstract = abstract
    }
}
