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
    
    let viewModel = StoriesDetailViewModel()
    var chosenIndex = Int()
    var validOrignialInfo: ValidStory?
    
    private func initialUISettings() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(shareThisNews))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialUISettings()
        parseResults()
    }
    
    private func parseResults() {
        viewModel.parseStoryDetail(chosnIndex: chosenIndex) { [ weak self ] error in
            guard let weakSelf = self, error == nil else { return }
            DispatchQueue.main.async {
                weakSelf.titleLabel.text = weakSelf.validOrignialInfo?.title
                weakSelf.timeLabel.text = weakSelf.validOrignialInfo?.formattedDateAndTimeString
                weakSelf.contentLabel.text = weakSelf.validOrignialInfo?.abstract
                
                weakSelf.typeLabel.text = weakSelf.viewModel.validRestDetail.type
                weakSelf.sourceLabel.text = weakSelf.viewModel.validRestDetail.source
                weakSelf.locationLaebl.text = weakSelf.viewModel.validRestDetail.location
                weakSelf.newsPhotoImageView.image = weakSelf.viewModel.validRestDetail.newsImage
                weakSelf.captionLabel.text = weakSelf.viewModel.validRestDetail.caption
            }
        }
    }
    
    @objc private func shareThisNews() {
        let firstActivityItem = validOrignialInfo?.title
        guard let secondActivityItem = validOrignialInfo?.url else { return }
        let thirdActivityItem = validOrignialInfo?.thumbImage
        
        let activityViewController = UIActivityViewController(activityItems: [firstActivityItem ?? "News Title", secondActivityItem, thirdActivityItem ?? UIImage(imageLiteralResourceName: AppConstants.newYorkTimeLogo)], applicationActivities: nil)
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
