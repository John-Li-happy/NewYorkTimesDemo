//
//  StoryDetailViewController.swift
//  NewYorkTimesDemo
//
//  Created by Zhaoyang Li on 10/31/20.
//

import UIKit

class StoryDetailViewController: UIViewController {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var sourceLabel: UILabel!
    @IBOutlet private weak var locationLaebl: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var newsPhotoImageView: UIImageView!
    @IBOutlet private weak var captionLabel: UILabel!
    
    var news: NewsProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialUISettings()
        displayResult()
    }
    
    private func initialUISettings() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(shareThisNews))
    }
    
    private func displayResult() {
        self.titleLabel.text = news?.title
        self.timeLabel.text = news?.timeString
        self.contentLabel.text = news?.abstract
        self.sourceLabel.text = news?.source
        self.locationLaebl.text = news?.section
        self.typeLabel.text = news?.subSection
        self.captionLabel.text = news?.multiMedia?.last?.caption
        self.newsPhotoImageView.setImage(withPath: news?.multiMedia?.last?.url ?? "", placeholderName: "NYTLogo")
    }
    
    @objc private func shareThisNews() {
        let firstActivityItem = news?.title
        guard let secondActivityItem = news?.newsDetailsUrl else { return }
        let thirdActivityItem = self.newsPhotoImageView.image ?? #imageLiteral(resourceName: "NYTLogo")
        
        let activityViewController = UIActivityViewController(activityItems: [firstActivityItem ?? "News Title", secondActivityItem, thirdActivityItem], applicationActivities: nil)
        if #available(iOS 13.0, *) {
            activityViewController.activityItemsConfiguration = [
                UIActivity.ActivityType.message
            ] as? UIActivityItemsConfigurationReading
        }
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToTencentWeibo,
            UIActivity.ActivityType.postToFacebook
        ]
        if #available(iOS 13.0, *) {
            activityViewController.isModalInPresentation = true
        }
        self.present(activityViewController, animated: true, completion: nil)
    }
}
