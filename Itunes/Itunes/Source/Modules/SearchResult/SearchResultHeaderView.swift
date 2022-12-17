//
//  SearchResultHeaderView.swift
//  Itunes
//
//  Created by Rahul C K on 13/12/22.
//

import UIKit

class SearchResultHeaderView: UICollectionReusableView {
    @IBOutlet weak var titleLabel: UILabel!

    func configure(title: String) {
        titleLabel.text = title
    }
}
