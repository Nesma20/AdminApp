//
//  SummaryCollectionViewCell.swift
//  AdminApp
//
//  Created by Ahmed M. Hassan on 7/8/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import UIKit

struct SummaryCellModel {
    let image: UIImage
    let type: String
    let value: String
    let details: String
}

class SummaryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(with model: SummaryCellModel) {
        iconImageView.image = model.image
        typeLabel.text = model.type
        valueLabel.text = model.value
        detailsLabel.text = model.details
    }


}
