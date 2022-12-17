//
//  SearchResultGridViewCell.swift
//  Itunes
//
//  Created by Rahul C K on 13/12/22.
//

import UIKit
import SDWebImage

class SearchResultGridViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    func configure(imageUrl: String?, title: String) {
        titleLabel.text = title
        if let imageUrl = imageUrl, let url = URL(string: imageUrl) {
            imageView.sd_setImage(with: url)
        }
    }
}
