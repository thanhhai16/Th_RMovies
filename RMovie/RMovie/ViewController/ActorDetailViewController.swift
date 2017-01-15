//
//  ActorDetailViewController.swift
//  RMovie
//
//  Created by Admin on 1/8/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit

class ActorDetailViewController: UIViewController {

    
    @IBOutlet weak var aImage: UIImageView!
    @IBOutlet weak var aName: UILabel!
    @IBOutlet weak var aBirthday: UILabel!
    @IBOutlet weak var aPlaceOfBirth: UILabel!
    @IBOutlet weak var aPopularity: UILabel!
    @IBOutlet weak var aBiography: UITextView!
    
//    @IBOutlet weak var movieCollectionView: ReferenceMovieCollection!
    
    @IBOutlet weak var movieContainerView: UIView!
    
    var actor : Actor!
    
    
    override func viewDidLoad() {
        self.setUI()
        print("this is actor detail view controller")
        super.viewDidLoad()
        let url = URL(string: actor.poster)
        
        print("------------------url of image : \(url)")
        self.aImage.sd_setImage(with: url)
        SearchManager.share.searchActorDetailInfo(id: actor.id) { (name, placeOfBirth, birthday, biography, popularity) in
            self.aName.text = name
            self.aPlaceOfBirth.text = placeOfBirth
            self.aBirthday.text = birthday
            self.aBiography.text = biography
            self.aPopularity.text = String(popularity)
        }
        
        SearchManager.share.searchActorDetailMovie(id: actor.id) { (movies) in
            let movieCollectionView = Bundle.main.loadNibNamed("ReferenceMovieCollection", owner: self, options: nil)?.first as? ReferenceMovieCollection
            movieCollectionView?.frame = self.movieContainerView.bounds
            movieCollectionView?.movies = movies
            self.movieContainerView.addSubview(movieCollectionView!)
            
//            self.movieCollectionView = Bundle.main.loadNibNamed("MovieCollection", owner: self, options: nil)?.first as? ReferenceMovieCollection
//            self.movieCollectionView?.movies = movies
//            self.view.addSubview(self.movieCollectionView!)
        }
        // Do any additional setup after loading the view.
    }

    func setUI() {
            self.aBiography.isEditable = false
        self.aImage.layer.cornerRadius = 10
        self.aName.font = UIFont.systemFont(ofSize: 23)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
