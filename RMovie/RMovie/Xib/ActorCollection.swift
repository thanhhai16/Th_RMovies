//
//  MovieCollection.swift
//  RMovie
//
//  Created by Hai on 1/2/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit

class ActorCollection: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = .none
        let nib = UINib(nibName: "ActorCell", bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: "ActorCell")
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActorCell", for: indexPath) as! ActorCell
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
