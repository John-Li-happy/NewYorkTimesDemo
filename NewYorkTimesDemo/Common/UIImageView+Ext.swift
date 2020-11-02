//
//  UIImageView+Ext.swift
//  NewYorkTimesDemo
//
//  Created by Amol Prakash on 02/11/20.
//

import SDWebImage

extension UIImageView {
    func setImage(withPath path: String, placeholderName: String, completion: SDExternalCompletionBlock? = nil) {
        var urlString = path

        if urlString.rangeOfCharacter(from: .whitespacesAndNewlines) != nil {
            urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        }
        self.sd_setImage(with: URL(string: urlString),
                         placeholderImage: UIImage(named: placeholderName),
                         completed: completion)
    }
}
