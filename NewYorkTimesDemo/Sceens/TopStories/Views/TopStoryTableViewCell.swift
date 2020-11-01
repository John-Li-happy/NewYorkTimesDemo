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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        headShotImageView.layer.cornerRadius = headShotImageView.frame.size.height / 2
        headShotImageView.layer.borderColor = UIColor.gray.cgColor
        headShotImageView.layer.borderWidth = 1.0
    }
    
    func configureCell(title: String, abstract: String, image: UIImage, postTime: String?) {
        titleLabel.text = title
        abstractLabel.text = abstract
        headShotImageView.image = image
        timeLabel.text = postTime
    }

}
