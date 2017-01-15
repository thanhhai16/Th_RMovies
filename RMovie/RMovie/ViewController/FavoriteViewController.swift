//
//  FavoriteViewController.swift
//  RMovie
//
//  Created by Hai on 1/2/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import expanding_collection

class FavoriteViewController: ExpandingViewController ,UICollectionViewDelegateFlowLayout,  DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {

   // @IBOutlet weak var tableview: UITableView!
    var cellsIsOpen = [Bool]()
    @IBOutlet var collectionview: UICollectionView!
    
    
    
    //let favoriteMovies = UserDefaults.standard.value(forKey: "favoriteMovies") as! [Movie]
    var favoriteMovies = [Int]()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.collectionview.delegate = self
        self.collectionview.dataSource = self
        self.collectionview.emptyDataSetSource = self
        self.collectionview.emptyDataSetDelegate = self
        
        
        let nib = UINib(nibName: "FavoriteViewCell", bundle: nil)
        collectionview.register(nib, forCellWithReuseIdentifier: "FavoriteViewCell")
       
        
        //self.collectionview.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    

    
    override func viewDidAppear(_ animated: Bool) {
        if (UserDefaults.standard.object(forKey: "favoriteMovies") != nil) {
            favoriteMovies = UserDefaults.standard.object(forKey: "favoriteMovies") as! [Int]
            for id in favoriteMovies {
                print(id)
            }
        }
        
        print(favoriteMovies.count)
        collectionview.reloadData()
        collectionview.reloadEmptyDataSet()
        
    }
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        let image = UIImage(named: "logo Rmovie tabbar.png")
        return image
        
    }
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "You have no items"
        let attribs = [
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: 18),
            NSForegroundColorAttributeName: UIColor.darkGray
        ]
        
        return NSAttributedString(string: text, attributes: attribs)
    }
    
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "Add items to track the moveis or actors that are impressive to you. Add your first item by tapping the favourite button in a movie/actor that you selected."
        
        let para = NSMutableParagraphStyle()
        para.lineBreakMode = NSLineBreakMode.byWordWrapping
        para.alignment = NSTextAlignment.center
        
        let attribs = [
            NSFontAttributeName: UIFont.systemFont(ofSize: 14),
            NSForegroundColorAttributeName: UIColor.lightGray,
            NSParagraphStyleAttributeName: para
        ]
        
        return NSAttributedString(string: text, attributes: attribs)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (favoriteMovies == nil) {
            return 0
        } else {
           // print(favoriteMovies.count)
            return (favoriteMovies.count)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var movies = Movie()
        var nameMovies : String!
        let defaultImage = UIImage(named: "logo Rmovie.png")
        let cell = self.collectionview.dequeueReusableCell(withReuseIdentifier: "FavoriteViewCell", for: indexPath) as! FavoriteViewCell
        cell.lblNameMovie.text = "Movies"
               // print(<#T##items: Any...##Any#>)
        SearchManager.share.searchMovieDetailFromMovieMediaId(id: favoriteMovies[indexPath.row]) { (movie) in
            movies = movie
            nameMovies = movies.name
            let url = URL(string: movies.poster)
            cell.movieImage.sd_setImage(with: url, placeholderImage: defaultImage)

            //  print(self.favoriteMovies[indexPath.count])
        }
        cell.lblNameMovie.text = nameMovies
       // cell.movieImage = image
        return cell
        
        //cell.lblNameMovie.text = String(favoriteMovies[indexPath.row])
        
        
    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath)
//        
//        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: [],
//                                   animations: {
//                                    cell!.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
//                                    
//        },
//                                   completion: { finished in
//                                    UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: .curveEaseInOut,
//                                                               animations: {
//                                                                cell!.transform = CGAffineTransform(scaleX: 1, y: 1)
//                                    },
//                                                               completion: { finished in
//                                                                self.test
//                                    )
//                                    
//        }
//        )    }
    func test(){
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 80)
    }

}
