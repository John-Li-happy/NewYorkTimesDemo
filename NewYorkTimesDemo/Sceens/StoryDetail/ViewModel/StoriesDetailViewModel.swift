//
//  StoriesDetailViewModel.swift
//  NewYorkTimesDemo
//
//  Created by Zhaoyang Li on 10/31/20.
//

import UIKit

class StoriesDetailViewModel {
    let topStoriesViewModel = TopStoriesViewModel()
    var validRestDetail = ValidRestStoryDetail(source: "", type: "", location: "", newsImage: UIImage(), caption: "")
    
    func parseStoryDetail(chosnIndex: Int, aSimpleHnadler handler: @escaping (Error?) -> ()) {
        let dataSource = TopStoriesViewModel.rareStoriesDataSource[chosnIndex]
        do {
            if let imageURLString = dataSource.multiMedia?.last?.url {
            guard let imageURL = URL(string: imageURLString) else { return }
            let imageData = try Data(contentsOf: imageURL)
            let image = UIImage(data: imageData)
            self.validRestDetail = ValidRestStoryDetail(source: dataSource.source ?? "Unknown",
                                                    type: dataSource.subSection ?? "General",
                                                    location: dataSource.section ?? "Unknown",
                                                    newsImage: image ?? UIImage(imageLiteralResourceName: AppConstants.newYorkTimeLogo),
                                                    caption: dataSource.multiMedia?.last?.caption ?? "Photo")
        } else {
            self.validRestDetail = ValidRestStoryDetail(source: dataSource.source ?? "Unknown",
                                                    type: dataSource.subSection ?? "General",
                                                    location: dataSource.section ?? "Unknown",
                                                    newsImage: UIImage(imageLiteralResourceName: AppConstants.newYorkTimeLogo),
                                                    caption: dataSource.multiMedia?.last?.caption ?? "Photo")
        }
        handler(nil)
        } catch { print(error.localizedDescription) }
    }
}
