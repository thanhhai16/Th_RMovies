//
//  FavoriteViewController.swift
//  RMovie
//
//  Created by Hai on 1/2/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var picking = 0 // picking=0: pick movie
                    // picking=1: pick actor
    var count = 0 // count number of movie or actor
    
    var movies :[Movie] = []
    var actors :[Actor] = []

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var lineSegment: LineSegment!
    @IBOutlet var segmentBtn: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        count = movies.count
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // load 2 mảng movies và actors
    }
    
    @IBAction func segmentBtnControll(_ sender: UIButton) {
        if sender == segmentBtn[0] {
            sender.setTitleColor(.white, for: .normal)
            segmentBtn[1].setTitleColor(UIColor.init(hexString: "929292"), for: .normal)
            self.lineSegment.animationLine(button: sender)
            
            picking=0
            count = movies.count
            collectionView.reloadData()
            
        } else {
            sender.setTitleColor(.white, for: .normal)
            segmentBtn[0].setTitleColor(UIColor.init(hexString: "929292"), for: .normal)
            self.lineSegment.animationLine(button: sender)
            
            picking=1
            count = actors.count
            collectionView.reloadData()
        }
    }
    
    
    //MARK: collection
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionCell
        
        if picking == 0 {
            for movie in movies {
                cell.movie = movie
                cell.name.text = movie.name
                cell.image.image = //ảnh của movie
            }
        }
        else {
            for actor in actors {
                cell.actor = actor
                cell.name.text = actor.name
                cell.image.image = //ảnh của actor
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionCell
        
        // chuyển sang view phim hoặc actor
        if picking == 0 {
            cell.movie
        }
        else {
            cell.actor
        }
    }
}

extension FavoriteViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width*2/5, height: collectionView.frame.height*19/50)
    }
}
