//
//  ReferenceMovieCollection.swift
//  RMovie
//
//  Created by Admin on 1/8/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit
import SDWebImage


class ReferenceMovieCollection: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var movies : [Movie]!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var vc : UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        self.backgroundColor = .none
        let nib = UINib(nibName: "MovieCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "MovieCell")
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let url = URL(string: movies[indexPath.row].poster)
        cell.poster.sd_setImage(with: url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let movie = ["movie": movies[indexPath.row]]
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: movieDetailNotification), object: nil, userInfo: movie)
        
        // su dung searchMovieDetail de lay chi tiet thong tin phim va hien thi MovieDetailScreen
        SearchManager.share.searchMovieDetail(media_type: movies[indexPath.row].media_type, id: movies[indexPath.row].id) { (movieSearched) in
            let movieVC = self.vc?.storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
            movieVC.movie =  movieSearched
            self.vc?.navigationController?.pushViewController(movieVC, animated: true)

        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width * 2/5, height: self.frame.height * 0.8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let leftInset = self.frame.height * 0.125
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: leftInset)
    }
    
    
}
