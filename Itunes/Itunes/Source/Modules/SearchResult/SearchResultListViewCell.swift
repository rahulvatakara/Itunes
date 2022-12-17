//
//  SearchResultListViewCell.swift
//  Itunes
//
//  Created by Rahul C K on 13/12/22.
//

import UIKit
import SDWebImage

class SearchResultListViewCell: UICollectionViewCell {
    @IBOutlet weak var descripLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    func configure(imageUrl: String?, title: String, description: String) {
        self.titleLabel.text = title
        self.descripLabel.text = description
        if let imageUrl = imageUrl, let url = URL(string: imageUrl) {
            imageView.sd_setImage(with: url)
        }
    }
}
