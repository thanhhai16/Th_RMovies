//
//  MovieDetailViewController.swift
//  RMovie
//
//  Created by Hai on 1/5/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit
import SwiftHEXColors
import XCDYouTubeKit
import RAMAnimatedTabBarController
import NVActivityIndicatorView

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: NVActivityIndicatorView!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var segmentView: UIView!
    @IBOutlet weak var posterContainer: UIView!
    @IBOutlet weak var lineSegment: LineSegment!
    @IBOutlet var segmentBtn: [UIButton]!
    @IBOutlet var movieInfo: [UILabel]!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var backdropImage: UIImageView!
    
    @IBOutlet weak var noResult: UILabel!
    var movie : Movie!
    var trailerPlayer = XCDYouTubeVideoPlayerViewController()
    var animateTabbar : RAMAnimatedTabBarController!
    var oldPosition : CGRect!
    var currentView : UIView!
    var reviewNull = false
    
    var showImage = false
    
    var infoView : InfoMovieView!
    var reviewView : MovieReviewView!
    var similarView : SimilarMovieView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUP()
        self.Notification()
        self.infoSetup()
        self.reviewSetup()
        self.similarSetup()
        self.gestureImage()
        self.activityIndicator.startAnimating()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.Notification()
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func gestureImage() {
            let tapImage = UITapGestureRecognizer(target: self, action: #selector(animateImage))
            self.posterImage.addGestureRecognizer(tapImage)
    }
    
    func Notification() {
        NotificationCenter.default.addObserver(self, selector: #selector(movieDetail), name: NSNotification.Name(rawValue: movieDetailFromSimilerNotification), object: nil)
    }

    
    func movieDetail(_ notification : Notification) {
        let movie = notification.userInfo?["movie"] as! Movie
        let movieDetailViewController = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        movieDetailViewController.movie = movie
        NotificationCenter.default.removeObserver(self)
        self.navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
    
    func imageOffAnimation() {
        if showImage {
        self.animateTabbar.animationTabBarHidden(false)
            ImageAnimation.share.animateOff(imageView: self.posterImage, imageContainer: self.posterContainer, oldPosition: self.oldPosition, view: self.view,background : self.background)
        self.showImage = false
            self.view.gestureRecognizers?.removeAll()
        }
    }
    func animateImage() {
        if !showImage {
        self.animateTabbar.animationTabBarHidden(true)
        ImageAnimation.share.animateOn(imageView: self.posterImage, view: self.view, imageContainer: self.posterContainer, background : self.background)
        self.showImage = true
            let imageOff = UITapGestureRecognizer(target: self, action: #selector(imageOffAnimation))
            self.view.addGestureRecognizer(imageOff)

        }
    }
    func similarSetup() {
        var movies = [Movie]()
        SearchManager.share.searhSimilarMovie(media_type: movie.media_type, id: movie.id) { (results) in
            for movie in results {
                movies.append(movie)
            }
            self.similarView.movies = movies
            self.view.addSubview(self.similarView)
        }
    
    }
    
    func reviewSetup() {
               var reviews = [String]()
        SearchManager.share.searchReview(media_type: movie.media_type, id: movie.id) { (results) in
            if results.count == 0 {
                self.reviewNull = true
                self.reviewView.reviews = reviews
                self.view.addSubview(self.reviewView)
            } else {
            for review in results {
                print("review", review)
                reviews.append(review)
            }
                self.reviewView.reviews = reviews
                self.view.addSubview(self.reviewView)
                self.noResult.isHidden = true
                self.reviewNull = false

            }
        }
       
    }
    func infoSetup() {
        var casts = [Actor]()
                SearchManager.share.searchMovieCast(mediaType: movie.media_type, id: movie.id) { (actors) in
            for actor in actors {
               casts.append(actor)
            }
            self.movie.casts = casts
            self.infoView.movie = self.movie
            self.infoView.setDecription()
            self.view.addSubview(self.infoView)
            self.activityIndicator.stopAnimating()
        }
    }
    @IBAction func invokePlayBtn(_ sender: UIButton) {
        SearchManager.share.searchTrailer(id: movie.id) { (youtubeId) in
            self.animateTabbar.animationTabBarHidden(true)
            self.trailerPlayer = XCDYouTubeVideoPlayerViewController(videoIdentifier: youtubeId)
            self.view.addSubview(self.trailerPlayer.view)
            NotificationCenter.default.addObserver(self, selector: #selector(self.hideTrailer), name: NSNotification.Name.MPMoviePlayerPlaybackDidFinish, object: self.trailerPlayer.moviePlayer)
            
        }
    }
    func hideTrailer() {
        self.animateTabbar.animationTabBarHidden(false)
        self.trailerPlayer.view.removeFromSuperview()
        trailerPlayer.dismiss(animated: true, completion: nil)
    }
    func setUP() {
        self.similarView = Bundle.main.loadNibNamed("SimilarMovieView", owner: nil, options: nil)?.first as! SimilarMovieView
        let height = self.view.frame.height * 220/568
        let y = self.view.frame.height - height * 21/20 - 50
        self.similarView.frame = CGRect(x: self.viewContainer.frame.origin.x, y: y, width: self.view.frame.width - 32, height: height)
        
        self.reviewView = Bundle.main.loadNibNamed("MovieReviewView", owner: nil, options: nil)?.first as! MovieReviewView
        self.reviewView.frame = CGRect(x: self.viewContainer.frame.origin.x, y: y, width: self.view.frame.width - 32, height: height)
        
        self.infoView =  Bundle.main.loadNibNamed("InfoMovieView", owner: nil, options: nil)?.first as! InfoMovieView
        self.infoView.frame = CGRect(x: self.viewContainer.frame.origin.x, y: y, width: self.view.frame.width - 32, height: height)

        self.reviewView.isHidden = true
        self.similarView.isHidden = true
        
        self.noResult.isHidden = true
        
        self.oldPosition = self.posterContainer.frame
        
        self.animateTabbar = self.tabBarController as! RAMAnimatedTabBarController!
        
        self.posterContainer.layer.shadowColor = UIColor.white.cgColor
            self.posterContainer.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.posterContainer.layer.shadowRadius = 3
        self.posterContainer.layer.shadowOpacity = 0.5
        let posterUrl = URL(string: (movie?.poster)!)
        self.posterImage.sd_setImage(with: posterUrl)
        self.posterImage.clipsToBounds = true
        self.posterImage.layer.borderWidth = 2
        self.posterImage.layer.borderColor = UIColor.white.cgColor

        
        let backdropUrl = URL(string: (movie?.backdrop)!)
        self.backdropImage.sd_setImage(with: backdropUrl)
        self.movieName.text = (movie.name)!
        self.movieInfo[0].text = movie?.year!
        self.movieInfo[1].text = "\((movie.score)!)"
        self.movieInfo[2].text = "\((movie.popularity)!)"
    }
    
    @IBAction func segmentControll(_ sender: UIButton) {
        switch sender {
        case segmentBtn[0]:
            self.noResult.isHidden = true
            self.infoView.isHidden = false
            self.reviewView.isHidden = true
            self.similarView.isHidden = true
            //self.currentView = self.infoView
            sender.setTitleColor(.white, for: .normal)
            self.lineSegment.animationLine(button: sender)
            segmentBtn[1].setTitleColor(UIColor.init(hexString: "929292"), for: .normal)
            segmentBtn[2].setTitleColor(UIColor.init(hexString: "929292"), for: .normal)
        case segmentBtn[1]:
            if reviewNull {
                self.noResult.isHidden = false
            }
            self.reviewView.isHidden = false
            self.infoView.isHidden = true
            self.similarView.isHidden = true
            //self.currentView = self.reviewView
            sender.setTitleColor(.white, for: .normal)
            self.lineSegment.animationLine(button: sender)
            segmentBtn[0].setTitleColor(UIColor.init(hexString: "929292"), for: .normal)
            segmentBtn[2].setTitleColor(UIColor.init(hexString: "929292"), for: .normal)
        case segmentBtn[2]:
            self.noResult.isHidden = true
            self.reviewView.isHidden = true
            self.infoView.isHidden = true
            self.similarView.isHidden = false
            sender.setTitleColor(.white, for: .normal)
            self.lineSegment.animationLine(button: sender)
            segmentBtn[0].setTitleColor(UIColor.init(hexString: "929292"), for: .normal)
            segmentBtn[1].setTitleColor(UIColor.init(hexString: "929292"), for: .normal)
        default:
            break
        }
    }
}
