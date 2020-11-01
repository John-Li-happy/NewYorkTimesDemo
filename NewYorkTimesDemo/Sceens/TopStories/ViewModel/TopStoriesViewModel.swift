//
//  TopStoriesViewModel.swift
//  NewYorkTimesDemo
//
//  Created by Zhaoyang Li on 10/31/20.
//

import UIKit

class TopStoriesViewModel {
    var validStoriesDataSource = [ValidStory]()
    static var rareStoriesDataSource = [Result]()
    
    func parseTopStoriesDataHandler(aSimpleHnadler handler: @escaping (Error?) -> ()) {
        let urlString = AppConstants.rooURLString
        let parameters = [AppConstants.apiKeyQuery: AppConstants.apiKeyValue]
        
        ServiceManager.shared.fetchData(url: urlString, parameters: parameters) { data, error in            
            guard let data = data, error == nil else { handler(error); return }
            do {
                let json = try JSONDecoder().decode(ResultsHolder.self, from: data)
                guard let results = json.results else { handler(error); return }
                TopStoriesViewModel.rareStoriesDataSource = results
                for result in results {
                    if let title = result.title,
                       let abstract = result.title,
                       let imageString = result.imageString,
                       let timeString = result.timeString,
                       let urlString = result.urlString {
                        guard let storyURL = URL(string: urlString) else { continue }
                        guard let imageUrl = URL(string: imageString) else { continue }
                        let imageData = try Data(contentsOf: imageUrl)
                        if let storyImage = UIImage(data: imageData) {
                            let singleValidStory = ValidStory(thumbImage: storyImage, title: title, time: timeString, url: storyURL, abstract: abstract)
                            self.validStoriesDataSource.append(singleValidStory)
                        } else {
                            let singleValidStory = ValidStory(thumbImage: UIImage(imageLiteralResourceName: AppConstants.newYorkTimeLogo), title: title, time: timeString, url: storyURL, abstract: abstract)
                            self.validStoriesDataSource.append(singleValidStory)
                        }
                    }
                }
                handler(nil)
            } catch {
                print("error in parsing", error.localizedDescription)
            }
        }
    }
    
}
