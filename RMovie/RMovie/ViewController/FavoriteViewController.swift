//
//  FavoriteViewController.swift
//  RMovie
//
//  Created by Hai on 1/2/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import DGElasticPullToRefresh

class FavoriteViewController: UIViewController , DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {

   // @IBOutlet weak var tableview: UITableView!
    var cellsIsOpen = [Bool]()
    var movies = [Movie]()
 
    fileprivate var tableview: UITableView!

    //let favoriteMovies = UserDefaults.standard.value(forKey: "favoriteMovies") as! [Movie]
    var favoriteMovies = [Int]()

    
    override func loadView() {
        
        super.loadView()
        
        tableview = UITableView(frame: view.bounds, style: .plain)
        tableview.dataSource = self
        tableview.delegate = self
        let castNib = UINib(nibName: "FavoriteTableViewCell", bundle: nil)
        self.tableview.register(castNib, forCellReuseIdentifier: "FavoriteTableViewCell")
        self.tableview.backgroundColor = UIColor.gray
        tableview.rowHeight = UITableViewAutomaticDimension
        view.addSubview(tableview)
        
        self.tableview.emptyDataSetSource = self
        self.tableview.emptyDataSetDelegate = self
        
        
        
        if (UserDefaults.standard.object(forKey: "favoriteMovies") != nil) {
            self.favoriteMovies = UserDefaults.standard.object(forKey: "favoriteMovies") as! [Int]
            
        }
        
        // print(self?.favoriteMovies.count)
        self.tableview.reloadData()
        self.tableview.reloadEmptyDataSet()

        
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
        tableview.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            // Add your logic here
            // Do not forget to call dg_stopLoading() at the end
            if (UserDefaults.standard.object(forKey: "favoriteMovies") != nil) {
                self?.favoriteMovies = UserDefaults.standard.object(forKey: "favoriteMovies") as! [Int]
                
            }
            
            // print(self?.favoriteMovies.count)
            self?.tableview.reloadData()
            self?.tableview.reloadEmptyDataSet()

            self?.tableview.dg_stopLoading()
            }, loadingView: loadingView)
        tableview.dg_setPullToRefreshFillColor(UIColor(red: 57/255.0, green: 67/255.0, blue: 89/255.0, alpha: 1.0))
        tableview.dg_setPullToRefreshBackgroundColor(tableview.backgroundColor!)
        
    }

    deinit {
        tableview.dg_removePullToRefresh()
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
}
extension FavoriteViewController : UITableViewDataSource , UITableViewDelegate{
    @available(iOS 2.0, *)

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (favoriteMovies == nil) {
            return 0
        } else {
            // print(favoriteMovies.count)
            return (favoriteMovies.count)
        }
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableview.cellForRow(at: indexPath)
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: [],
                       animations: {
                        cell!.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                        
        },
                       completion: { finished in
                        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: .curveEaseInOut,
                                       animations: {
                                        cell!.transform = CGAffineTransform(scaleX: 1, y: 1)
                        },
                                       completion: { finished in
                                        SearchManager.share.searchMovieDetailFromMovieMediaId(id: self.favoriteMovies[indexPath.row]) { (movie) in
                                            let movieDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
                                            movieDetailViewController.movie = movie
                                            
                                            self.navigationController?.pushViewController(movieDetailViewController, animated: true)
                                        }
                                        
                        })
                        
        }
        )

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var moviexx = Movie()
        var nameMovies : String!
        let defaultImage = UIImage(named: "logo Rmovie.png")
        let cell = self.tableview.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell") as! FavoriteTableViewCell
        cell.movieName.text = "Movies"
        // print(<#T##items: Any...##Any#>)
        SearchManager.share.searchMovieDetailFromMovieMediaId(id: favoriteMovies[indexPath.row]) { (movie) in
            moviexx = movie
            nameMovies = moviexx.name
            let url = URL(string: moviexx.poster)
            self.movies.append(movie)
            cell.movieImage.sd_setImage(with: url, placeholderImage: defaultImage)
            cell.movieName.text = nameMovies
            //  print(self.favoriteMovies[indexPath.count])
        }
        
       // print(nameMovies)
        // cell.movieImage = image
        return cell
        
        //cell.lblNameMovie.text = String(favoriteMovies[indexPath.row])

    }

}
