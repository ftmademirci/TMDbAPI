//
//  MovieCastCollectionViewCell.swift
//  TMDbAPI
//
//  Created by Fatma Demirci on 20.10.2020.
//

import UIKit

class MovieCastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieCastImageView: UIImageView!
    @IBOutlet weak var movieCastTitleLabel: UILabel!
    @IBOutlet weak var movieCastCreditLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
