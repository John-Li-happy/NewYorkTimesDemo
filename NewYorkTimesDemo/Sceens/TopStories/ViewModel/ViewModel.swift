//
//  ViewModel.swift
//  NewYorkTimesDemo
//
//  Created by Zhaoyang Li on 10/31/20.
//

import UIKit

class ViewModel {
    var validStoriesDataSource = [ValidStory]()
    
    func parseTopStoriesDataHandler(aSimpleHnadler handler: @escaping (Error?) -> ()) {
        let urlString = "https://api.nytimes.com/svc/news/v3/content/all/all.json"
        let parameters = ["api-key": "giiGgfGdJ8iYtTNQWuwSUquiIjtJM0n2"]
        
        ServiceManager.shared.fetchData(url: urlString, parameters: parameters) { data, error in
            print(data ?? "")
            
            guard let data = data, error == nil else { handler(error); return }
            do {
                let json = try JSONDecoder().decode(ResultsHolder.self, from: data)
                guard let results = json.results else { handler(error); return }
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
                            let singleValidStory = ValidStory(thumbImage: UIImage(imageLiteralResourceName: "NYTLogo"), title: title, time: timeString, url: storyURL, abstract: abstract)
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
