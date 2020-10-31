//
//  TopStoryTableViewCell.swift
//  NewYorkTimesDemo
//
//  Created by Zhaoyang Li on 10/31/20.
//

import UIKit

class TopStoryTableViewCell: UITableViewCell, ReusableCellProtocol {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var abstractLabel: UILabel!
    @IBOutlet private weak var headShotImageView: UIImageView!
    @IBOutlet private weak var timeLabel: UILabel!
    
    func configureCell(title: String, abstract: String, image: UIImage, postTime: String) {
        titleLabel.text = title
        abstractLabel.text = abstract
        headShotImageView.image = image
        timeLabel.text = postTime
    }

}
