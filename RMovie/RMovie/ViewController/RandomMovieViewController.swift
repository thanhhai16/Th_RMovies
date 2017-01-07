//
//  RandomMovieViewController.swift
//  RMovie
//
//  Created by mac on 1/8/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit

class RandomMovieViewController: UIViewController {

    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var lblNameMovies: UILabel!
    
    @IBOutlet weak var posterImage: UIImageView!
    var movie = Movie()
    
    let recognizer = UITapGestureRecognizer()
    override func viewDidLoad() {
        super.viewDidLoad()
    
        lblNameMovies.isHidden = true
        lblNameMovies.sizeToFit()
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.randomTopMovies))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeDown)
        
        self.posterImage.isUserInteractionEnabled = true
        recognizer.addTarget(self, action: "handleTap")

        self.posterImage.addGestureRecognizer(recognizer)
        progressLoopMovie()
    }

    func handleTap() {
        let movieDetailViewController = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        movieDetailViewController.movie = movie
        
        self.navigationController?.pushViewController(movieDetailViewController, animated: true)

    }
    
    func randomTopMovies(){
        let rad = Int(arc4random_uniform(UInt32(appDelegate.countTopFilmRest)))
        appDelegate.countTopFilmRest -= 1
        print(appDelegate.countTopFilmRest)
        movie = appDelegate.topMovies[rad]
 
        let url = URL(string: movie.poster)
        print(url)
        self.posterImage.sd_setImage(with: url)
        lblNameMovies.isHidden = false
        lblNameMovies.text = movie.name
        appDelegate.topMovies.remove(at: rad)
        print(appDelegate.topMovies.count)
    }

    func progressLoopMovie()  {
        var checkFilmSelected = Array(repeating: false, count: 100000000)
        var count = 0
        for movie in appDelegate.topMovies {
            if (checkFilmSelected[movie.id]) {
                appDelegate.topMovies.remove(at: count)
            } else {
                count += 1
                checkFilmSelected[movie.id] = true
            }
        }
    }
}
