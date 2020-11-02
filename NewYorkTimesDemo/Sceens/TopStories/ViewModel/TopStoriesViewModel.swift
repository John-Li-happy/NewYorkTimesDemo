//
//  TopStoriesViewModel.swift
//  NewYorkTimesDemo
//
//  Created by Zhaoyang Li on 10/31/20.
//

import UIKit

protocol TopStoriesViewModelProtocol {
    func fetchedResults()
    func didFail(message: String)
    func showActivity()
    func hideActivity()
    func startRefresh()
    func stopRefresh()
}

class TopStoriesViewModel {
    
    private var dataSource: [NewsProtocol]  = [] {
        didSet {
            self.delegate.fetchedResults()
        }
    }
    
    var delegate: TopStoriesViewModelProtocol
    
    init(delegate: TopStoriesViewModelProtocol) {
        self.delegate = delegate
    }
    
    func numberOfRows() -> Int {
        self.dataSource.count
    }
    
    func news(atIndex index: Int) -> NewsProtocol {
        self.dataSource[index]
    }
    
    func getAllResults(isRefresh: Bool = false) {
        if isRefresh {
            self.delegate.hideActivity()
            self.delegate.startRefresh()
        } else {
            self.delegate.showActivity()
            self.delegate.stopRefresh()
        }
        
        let parameters = [AppConstants.apiKeyQuery: AppConstants.apiKeyValue]
        ServiceManager.shared.fetchData(url: AppConstants.rootURLString, parameters: parameters, type: Response.self) { response, error in
            self.delegate.hideActivity()
            self.delegate.stopRefresh()
            guard let response = response else {
                self.delegate.didFail(message: error?.localizedDescription ?? "")
                return
            }
                
            guard let result = response.results else {
                self.delegate.didFail(message: "")
                return
            }
            var allResults = [NewsCellViewModel]()
            result.forEach { news in
                let cellModel = NewsCellViewModel(news)
                allResults.append(cellModel)
            }
            self.dataSource = allResults
        }
    }
}

class NewsCellViewModel: NewsProtocol {
    
    private var newsData: NewsData
    
    required init(_ newsData: NewsData) {
        self.newsData = newsData
    }
    
    var title: String? {
        self.newsData.title
    }
    
    var abstract: String? {
        self.newsData.abstract
    }
    
    var newsDetailsUrl: String? {
        self.newsData.newsDetailsUrl
    }
    
    var imageUrl: String? {
        self.newsData.imageUrl
    }
    
    var timeString: String? {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let timeString = self.newsData.timeString,
            let date = dateFormatter.date(from: timeString) else { return nil }
        dateFormatter.dateFormat = "MMM d, yyyy, h:mm a"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    var source: String? {
        self.newsData.source
    }
    
    var subSection: String? {
        self.newsData.subSection
    }
    
    var section: String? {
        self.newsData.section
    }
    
    var multiMedia: [MultiMedia]? {
        self.newsData.multiMedia
    }
}

