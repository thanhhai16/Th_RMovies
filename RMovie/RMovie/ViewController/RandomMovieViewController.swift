//
//  RandomMovieViewController.swift
//  RMovie
//
//  Created by mac on 1/8/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit
import SCLAlertView


class RandomMovieViewController: UIViewController {

    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var checkInternet = InternetStatus.share.checkInternet()
    
    @IBOutlet weak var lblNameMovies: UILabel!
    
    @IBOutlet weak var posterImage: UIImageView!
    var movie = Movie()
 
    
    let recognizer = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setting for label Name Movies
        lblNameMovies.isHidden = true
        lblNameMovies.sizeToFit()
        self.posterImage.isUserInteractionEnabled = false
    }
    override func viewDidAppear(_ animated: Bool) {
        checkInternet = InternetStatus.share.checkInternet()
        if (!checkInternet) {
            InternetStatus.share.showAlert()
        }
        
        //setting for swipe down
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.randomTopMovies))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeDown)
        
        // tapping in poster Image -> go to info of this movies
        recognizer.addTarget(self, action: #selector(RandomMovieViewController.handleTap))
        self.posterImage.addGestureRecognizer(recognizer)
       
        
        /* slove situation that some movies in topMovies Array are repeat .
         Why loop ? Because api that i use to down info movies just provie only 20 movies per page.
         So i must use 5 for loop to get 100 top movies. Moreover, 1 loop include completion(movies)
         (movies is array
         
         */
        progressRepeaterMovies()

        
    }

    func handleTap() {
        checkInternet = InternetStatus.share.checkInternet()
        if (!checkInternet) {
            InternetStatus.share.showAlert()
            return
        }
        
        let movieDetailViewController = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        movieDetailViewController.movie = movie
        
        self.navigationController?.pushViewController(movieDetailViewController, animated: true)

    }
    
    func randomTopMovies(){
        self.posterImage.isUserInteractionEnabled = true

        checkInternet = InternetStatus.share.checkInternet()
        if (!checkInternet) {
            InternetStatus.share.showAlert()
        
            return
        }
        
        let rad = Int(arc4random_uniform(UInt32(appDelegate.countTopFilmRest)))
        appDelegate.countTopFilmRest -= 1
        //print(appDelegate.countTopFilmRest)
        movie = appDelegate.topMovies[rad]
 
        let url = URL(string: movie.poster)
        //print(url)
        self.posterImage.sd_setImage(with: url)
        lblNameMovies.isHidden = false
        lblNameMovies.text = movie.name
        appDelegate.topMovies.remove(at: rad)
        print(appDelegate.topMovies.count)
    }

    func progressRepeaterMovies()  {
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
