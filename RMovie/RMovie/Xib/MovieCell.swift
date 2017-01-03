//
//  MovieCell.swift
//  RMovie
//
//  Created by Hai on 1/2/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieScore: UILabel!
    
    @IBOutlet weak var circle: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUP()
        
    }
    func setUP () {
        self.circle.isHidden = false
        self.layer.cornerRadius = 10
        self.moviePoster.clipsToBounds = true
        self.moviePoster.layer.cornerRadius = 10
        self.imageContainer.layer.shadowColor = UIColor.black.cgColor
        self.imageContainer.layer.shadowOffset = CGSize(width: 0, height: 10)
        self.imageContainer.layer.shadowRadius = 5
        self.imageContainer.layer.shadowOpacity = 0.5
    }
    
    
}
