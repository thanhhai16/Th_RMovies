//
//  MovieCollection.swift
//  RMovie
//
//  Created by Hai on 1/2/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit

class ActorCollection: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var layout: LNICoverFlowLayout!
    
    var actors : [Actor]!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = .none
        let nib = UINib(nibName: "SearchCell", bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: "SearchCell")
    }
    
    func setUP ()  {
        self.layout.itemSize = CGSize(width: self.frame.width * 3/4 * 3/4, height: self.frame.width * 1.125 * 3/4)
        self.layout.coverDensity = 0.15
        self.layout.minCoverOpacity = 0.2
        self.layout.minCoverScale = 0.5
    }
    
    // DataSoucre Method
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.actors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as! SearchCell
        cell.labelName.text = self.actors[indexPath.row].name
        let url = URL(string: actors[indexPath.row].poster)
        cell.poster.sd_setImage(with: url)
        cell.circle.isHidden = true
        cell.movieScore.isHidden  = true
        cell.alpha = 0
        return cell
    }
}
