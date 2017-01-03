//
//  ActorCell.swift
//  RMovie
//
//  Created by Hai on 1/2/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit

class ActorCell: UICollectionViewCell {
    
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var actorPoster: UIImageView!
    @IBOutlet weak var actorName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUP()
        
    }
    func setUP () {
        self.layoutIfNeeded()
        self.layer.cornerRadius = 10
        self.actorPoster.clipsToBounds = true
        self.actorPoster.layer.cornerRadius = 10
        self.imageContainer.layer.shadowColor = UIColor.black.cgColor
        self.imageContainer.layer.shadowOffset = CGSize(width: 0, height: 10)
        self.imageContainer.layer.shadowRadius = 5
        self.imageContainer.layer.shadowOpacity = 0.5
    }
    

}
