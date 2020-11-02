//
//  AppConstants.swift
//  NewYorkTimesDemo
//
//  Created by Zhaoyang Li on 10/31/20.
//

import Foundation

enum AppConstants {
    static let newYorkTimeLogo = "NYTLogo"
    static let rootURLString = "https://api.nytimes.com/svc/news/v3/content/all/all.json"
    static let apiKeyValue = "giiGgfGdJ8iYtTNQWuwSUquiIjtJM0n2"
    static let apiKeyQuery = "api-key"
    
    enum StoryBoardViews {
        static let storyBoardName = "Main"
        static let storyDetailViewController = "StoryDetailViewController"
    }
}

var dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    return dateFormatter
}()
