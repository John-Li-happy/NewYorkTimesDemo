//
//  NewsData.swift
//  NewYorkTimesDemo
//
//  Created by Zhaoyang Li on 10/31/20.
//

import UIKit

struct Response: Decodable {
    var status: String?
    var copyright: String?
    var numResults: Int?
    var results: [NewsData]?
    
    enum CodingKeys: String, CodingKey {
        case numResults = "num_results"
        case status
        case results
        case copyright
    }
}

struct NewsData: Decodable {
    
    var title: String?
    var abstract: String?
    var newsDetailsUrl: String?
    var imageUrl: String?
    var timeString: String?
    var source: String?
    var subSection: String?
    var section: String?
    var multiMedia: [MultiMedia]?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case abstract = "abstract"
        case newsDetailsUrl = "url"
        case imageUrl = "thumbnail_standard"
        case timeString = "updated_date"
        case source = "source"
        case subSection = "subsection"
        case section = "section"
        case multiMedia = "multimedia"
    }
}

struct MultiMedia: Decodable {
    var url: String?
    var caption: String?
    var copyright: String?
}

protocol NewsProtocol {    
    var title: String? { get }
    var abstract: String? { get }
    var newsDetailsUrl: String? { get }
    var imageUrl: String? { get }
    var timeString: String? { get }
    var source: String? { get }
    var subSection: String? { get }
    var section: String? { get }
    var multiMedia: [MultiMedia]? { get }
}
