//
//  SearchManager.swift
//  RMovie
//
//  Created by Hai on 1/2/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SearchManager {
    
    static let share = SearchManager()
    
    func searchMovie(searchText : String,completion: @escaping(_ movies: [Movie]) -> Void) {
        var movies = [Movie]()
        let url = (movieSearchUrl + searchText).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        Alamofire.request(url!).responseJSON { (reponse) in
            guard let value = reponse.result.value else {
                return
            }
            let json = JSON(value)
            guard let results = json["results"].array else {
                return
            }
            for result in results {
                let movie = Movie()
                guard let id = result["id"].int else {
                    return
                }
                guard let name = result["original_title"].string else {
                    return
                }
                print("name", name)
                guard let poster = result["poster_path"].string else {
                    return
                }
                print("poster",poster)
                guard let backdrop = result["backdrop_path"].string else {
                    return
                }
                guard let popularity = result["popularity"].float else {
                    return
                }
                guard let overview = result["overview"].string else {
                    return
                }
                guard let release_date = result["release_date"].string else {
                    return
                }
                guard let score = result["vote_average"].float else {
                    return
                }
                print("score", score)
                let range = release_date.startIndex..<release_date.index(release_date.startIndex, offsetBy: 5)
                let year = release_date[range]
                movie.id = id
                movie.name = name
                movie.poster = poster
                movie.backdrop = backdrop
                movie.popularity = popularity
                movie.overview = overview
                movie.year = year
                movie.score = score
                movies.append(movie)
            }
            completion(movies)
        }
       
    }
}

