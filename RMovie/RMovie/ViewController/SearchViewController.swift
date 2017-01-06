//
//  ViewController.swift
//  RMovie
//
//  Created by Hai on 1/1/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit
import BetterSegmentedControl
import SwiftHEXColors

class SearchViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var segmentBtn: [UIButton]!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var segmentControl: BetterSegmentedControl!
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var segmentView: UIView!
    @IBOutlet weak var lineSegment: LineSegment!
    var noResultText = UILabel()
    var movieCollectionView : MovieCollection?
    var actorCollectionView : ActorCollection?
    var segmentActor = false
    var actorNull = false
    var movieNull = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        self.Notification()
    }
    
    @IBAction func segmentBtnControll(_ sender: UIButton) {
        if sender == segmentBtn[0] {
            sender.setTitleColor(.white, for: .normal)
            segmentBtn[1].setTitleColor(UIColor.init(hexString: "929292"), for: .normal)

            if self.actorNull {
                self.noResultText.isHidden = true
            }
            if self.movieNull {
                self.noResultText.isHidden = false
            }
            self.lineSegment.animationLine(button: sender)
            self.movieCollectionView?.isHidden = false
            self.actorCollectionView?.isHidden = true
            self.segmentActor = false
        } else {
            sender.setTitleColor(.white, for: .normal)
            segmentBtn[0].setTitleColor(UIColor.init(hexString: "929292"), for: .normal)
            if self.actorNull {
                self.noResultText.isHidden = false
            }
            if self.movieNull {
                self.noResultText.isHidden = true
            }
            self.lineSegment.animationLine(button: sender)
            self.movieCollectionView?.isHidden = true
            self.actorCollectionView?.isHidden = false
            self.segmentActor = true
            
        }
    }
    func Notification() {
        NotificationCenter.default.addObserver(self, selector: #selector(movieDetail), name: NSNotification.Name(rawValue: movieDetailNotification), object: nil)
    }
    
    func movieDetail(_ notification : Notification) {
        let movie = notification.userInfo?["movie"] as! Movie
        let movieDetailViewController = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        movieDetailViewController.movie = movie
        self.navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        self.segmentView.isHidden = false
        self.fetchMovies(searchText: textField.text!)
        self.fetchActors(searchText: textField.text!)
        return true
    }
    
    func fetchMovies(searchText:String) {
        self.movieCollectionView?.removeFromSuperview()
        var movies = [Movie]()
        SearchManager.share.searchMovie(searchText: searchText) { (null, results) in
            if null {
                if self.segmentActor {
                    self.movieCollectionView?.isHidden = true
                    self.movieNull = true
                } else {
                    self.noResultText.isHidden = false
                }
            } else {
                for movie in results {
                    movies.append(movie)
                }
                self.movieCollectionView = Bundle.main.loadNibNamed("MovieCollection", owner: nil, options: nil)?.first as? MovieCollection
                self.movieCollectionView?.movies = movies
                self.view.addSubview(self.movieCollectionView!)
                self.movieCollectionView?.frame = CGRect(x: 0, y:self.view.frame.height/4.5, width: self.view.frame.width, height: self.view.frame.height * 0.65)
                if self.segmentActor {
                    self.movieCollectionView?.isHidden = true
                }
            }
        }
    }
    func fetchActors(searchText : String) {
        self.actorCollectionView?.removeFromSuperview()
        var actors = [Actor]()
        SearchManager.share.searchPeople(searchText: searchText) { (null, results) in
            if null {
                if !self.segmentActor {
                    self.actorCollectionView?.isHidden = true
                    self.actorNull = true
                } else {
                    self.noResultText.isHidden = false
                }
            } else {
                for actor in results {
                    actors.append(actor)
                }
                self.actorCollectionView = Bundle.main.loadNibNamed("ActorCollection", owner: nil, options: nil)?.first as? ActorCollection
                self.actorCollectionView?.actors = actors
                self.view.addSubview(self.actorCollectionView!)
                self.actorCollectionView?.frame = CGRect(x: 0, y:self.view.frame.height/4.5, width: self.view.frame.width, height: self.view.frame.height * 0.65)
                if !self.segmentActor {
                    self.actorCollectionView?.isHidden = true
                }
            }
        }
    }
    
    func setUp() {
        self.searchTextField.isHidden = true
        self.searchTextField.delegate = self
        self.segmentView.isHidden = true
        self.noResultText.text = "No Result"
        self.noResultText.textColor = UIColor.lightGray
        self.noResultText.font.withSize(16)
        self.noResultText.textAlignment = .center
        self.view.addSubview(self.noResultText)
        self.noResultText.frame.size = CGSize(width: self.view.frame.width, height: 30)
        self.noResultText.center = self.view.center
        self.noResultText.isHidden = true
    }
    
    @IBAction func invokeSearchBtn(_ sender: Any) {
        self.searchTextField.isHidden = false
        self.searchTextField.becomeFirstResponder()
    }
    
}

