//
//  ViewController.swift
//  RMovie
//
//  Created by Hai on 1/1/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit
import BetterSegmentedControl

class SearchViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var lineSegment: LineSegment!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var segmentControl: BetterSegmentedControl!
    @IBOutlet weak var searchTextField: UITextField!
    
    var movieCollectionView : MovieCollection?
    var actorCollectionView : ActorCollection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        self.segmentControll()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        self.fetchMovies(searchText: textField.text!)
        self.lineSegment.animationLine(moveBack: false)
        return true
    }
    
    func fetchMovies(searchText:String) {
        var movies = [Movie]()
        SearchManager.share.searchMovie(searchText: searchText) { results in
            for movie in results {
                print("a22e", movie.name)
                movies.append(movie)
            }
            self.movieCollectionView = Bundle.main.loadNibNamed("MovieCollection", owner: nil, options: nil)?.first as? MovieCollection
            self.movieCollectionView?.movies = movies
            print("count", movies.count)
            self.view.addSubview(self.movieCollectionView!)
            self.movieCollectionView?.frame = CGRect(x: 0, y:self.view.frame.height/4.5, width: self.view.frame.width, height: self.view.frame.height * 0.65)
        }
    }
    
    func segmentControll() {
        self.segmentControl.titles = ["Movies", "Actor"]
    }
    
    func setupActorCollection() {
        self.actorCollectionView = Bundle.main.loadNibNamed("ActorCollection", owner: nil, options: nil)?.first as? ActorCollection
        self.view.addSubview(actorCollectionView!)
        self.actorCollectionView?.frame = CGRect(x: 0, y:self.view.frame.height/4.5, width: self.view.frame.width, height: self.view.frame.height * 0.65)
    }

    func setUp() {
        self.searchTextField.isHidden = true
        self.searchTextField.delegate = self
    }

    @IBAction func invokeSearchBtn(_ sender: Any) {
        self.searchTextField.isHidden = false
    }

}

