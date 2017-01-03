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
        let nib = UINib(nibName: "MovieCell", bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: "MovieCell")
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.movieName.text = movies[indexPath.row].name
        print("text",cell.movieName.text)
        let url = URL(string: imageGetUrl + movies[indexPath.row].poster)
        cell.moviePoster.sd_setImage(with: url)
        cell.movieScore.text = "\(movies[indexPath.row].score!)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width * 3/4, height: self.frame.width * 1.125)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let leftInset = self.frame.height * 0.125
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: leftInset)
    }
    

}
