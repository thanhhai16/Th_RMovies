//
//  MovieCollection.swift
//  RMovie
//
//  Created by Hai on 1/2/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit
import SDWebImage


class MovieCollection: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var movies : [Movie]!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = .none
        let nib = UINib(nibName: "SearchCell", bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: "SearchCell")
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as! SearchCell
        cell.labelName.text = movies[indexPath.row].name
        let url = URL(string: movies[indexPath.row].poster)
        cell.poster.sd_setImage(with: url)
        cell.movieScore.text = "\(movies[indexPath.row].score!)"
        cell.alpha = 0
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = ["movie": movies[indexPath.row]]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: movieDetailNotification), object: nil, userInfo: movie)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let r : UInt32 = arc4random_uniform(2)
        if r == 0 {
            UIView.transition(with: cell, duration: 1, options: .transitionFlipFromLeft, animations: { 
                cell.alpha = 1
            }, completion: nil)
        }
        if r == 1 {
            UIView.transition(with: cell, duration: 1, options: .transitionFlipFromRight, animations: {
                cell.alpha = 1
            }, completion: nil)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width * 3/4, height: self.frame.width * 1.125)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let leftInset = self.frame.height * 0.125
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: leftInset)
    }
    

}
