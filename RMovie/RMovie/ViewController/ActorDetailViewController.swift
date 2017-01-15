//
//  ActorDetailViewController.swift
//  RMovie
//
//  Created by Admin on 1/8/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit

class ActorDetailViewController: UIViewController, UIGestureRecognizerDelegate {
    
    
    @IBOutlet weak var aImage: UIImageView!
    @IBOutlet weak var aName: UILabel!
    @IBOutlet weak var aBirthday: UILabel!
    @IBOutlet weak var aPlaceOfBirth: UILabel!
    @IBOutlet weak var aPopularity: UILabel!
    @IBOutlet weak var aBiography: UITextView!
    
    //    @IBOutlet weak var movieCollectionView: ReferenceMovieCollection!
    
    @IBOutlet weak var movieContainerView: UIView!
    
    var actor : Actor!
    var animationState = 0
    var imageFrameSmall : CGRect!
    var imageFrameBig : CGRect!
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
            self.aBiography.text = "\n" + biography
            self.aPopularity.text = String(popularity)
            
            self.imageFrameSmall = self.aImage.frame
            self.imageFrameBig = self.view.frame
            //        print("frame gbig and small :")
            self.aImage.frame = self.aImage.frame
            //        print(self.imageFrameBig)
            //        print(self.imageFrameSmall)
        }
        
        self.addTapGesture()
        
        SearchManager.share.searchActorDetailMovie(id: actor.id) { (movies) in
            let movieCollectionView = Bundle.main.loadNibNamed("ReferenceMovieCollection", owner: self, options: nil)?.first as? ReferenceMovieCollection
            movieCollectionView?.vc = self
            movieCollectionView?.frame = self.movieContainerView.bounds
            movieCollectionView?.movies = movies
            self.movieContainerView.addSubview(movieCollectionView!)
            
            //            self.movieCollectionView = Bundle.main.loadNibNamed("MovieCollection", owner: self, options: nil)?.first as? ReferenceMovieCollection
            //            self.movieCollectionView?.movies = movies
            //            self.view.addSubview(self.movieCollectionView!)
        }
        // Do any additional setup after loading the view.
    }
    
    func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.delegate = self
        self.aImage.isUserInteractionEnabled = true
        self.aImage.addGestureRecognizer(tap)
    }
    
    func handleTap() {
        print("tap image")
        if animationState == 0 {
            print(self.imageFrameBig)
            UIView.animate(withDuration: 0.6, animations: {
                self.aImage.frame = self.imageFrameBig
                }, completion: { (_) in
                    self.animationState = 1
            })
        }
        else    {
            print(self.imageFrameSmall)
            UIView.animate(withDuration: 0.6, animations: {
                self.aImage.frame = self.imageFrameSmall
                }, completion: { (_) in
                    self.animationState = 0
            })
            
        }
    }
    func setUI() {
        self.title = "Actor Screen"
        self.aBiography.isEditable = false
        self.aImage.layer.masksToBounds = true
        self.aImage.layer.cornerRadius = 10
        self.aName.font = UIFont.systemFont(ofSize: 23)
    }
    
    
    //    @IBAction func tapImage(_ sender: AnyObject) {
    //        print("tap image")
    //        if animationState == 0 {
    //            UIView.animate(withDuration: 0.3, animations: {
    //                self.aImage.frame = self.view.frame
    //            })
    //            animationState = 1
    //        }   else    {
    //            UIView.animate(withDuration: 0.3, animations: {
    //                self.aImage.frame = self.imageFrame
    //            })
    //            animationState = 0
    //        }
    //    }
    @IBAction func swipeBack(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
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
