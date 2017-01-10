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
    var topMovies = [Movie]()
    
    func searchPeople(searchText: String, completion : @escaping(_ null : Bool, _ people: [Actor]) -> Void) {
        var actors = [Actor]()
        let url = (actorSearchUrl + searchText).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        Alamofire.request(url!).responseJSON { (reponse) in
            guard let value =  reponse.result.value else {
                return
            }
            let json = JSON(value)
            
            guard let results = json["results"].array else {
                return
            }
            for result in results {
                let actor = Actor()
                
                guard let id = result["id"].int else {
                    return
                }
                actor.id = id
                guard let name = result["name"].string else {
                    return
                }
                actor.name = name
                guard let popularity = result["popularity"].float else {
                    return
                }
                actor.popularity = popularity
                let posterPath = result["profile_path"].string
                if posterPath != nil {
                    let poster = imageGetUrl + posterPath!
                    actor.poster = poster
                } else {
                    actor.poster = "https://s-media-cache-ak0.pinimg.com/736x/eb/c8/89/ebc88941781c6547b3f33d520d603779.jpg"
                }
                actors.append(actor)
            }
            if actors.count == 0 {
                completion(true, actors)
            } else {
                completion(false, actors)
            }
        }
    }
    
    func searchMovie(searchText : String,completion: @escaping(_ null: Bool, _ movies: [Movie]) -> Void) {
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
                let media = result["media_type"].string
                if media == person {
                    print("abe")
                }else {
                    // Check what kind (person, media, tv)
                    switch media {
                    case tv? :
                        movie.media_type = media
                        guard let name = result["name"].string else {
                            return
                        }
                        movie.name = name
                        guard let release_date = result["first_air_date"].string else {
                            return
                        }
                        if release_date == "" {
                            let year = "unknow"
                            movie.year = year
                        } else {
                            let range = release_date.startIndex..<release_date.index(release_date.startIndex, offsetBy: 4)
                            let year = release_date[range]
                            movie.year = year
                        }
                    case movieMedia? :
                        movie.media_type = media
                        guard let name = result["original_title"].string else {
                            return
                        }
                        movie.name = name
                        guard let release_date = result["release_date"].string else {
                            return
                        }
                        if release_date == "" {
                            let year = "unknow"
                            movie.year = year
                        } else {
                            let range = release_date.startIndex..<release_date.index(release_date.startIndex, offsetBy: 4)
                            let year = release_date[range]
                            movie.year = year
                        }
                    default:
                        break
                    }
                    guard let id = result["id"].int else {
                        break
                    }
                    movie.id = id
                    guard let overview = result["overview"].string else {
                        return
                    }
                    movie.overview = overview
                    print("overview", movie.overview)
                    guard let score = result["vote_average"].float else {
                        return
                    }
                    guard let genresResult = result["genre_ids"].array else {
                        return
                    }
                    var genres = [Int]()
                    for genre in genresResult {
                        let gen = Int(genre.number!)
                        genres.append(gen)
                    }
                    movie.genre = genres
                    print("genre", movie.genre)
                    movie.score = score
                    print("score", score)
                    guard let popularity = result["popularity"].float else {
                        return
                    }
                    movie.popularity = popularity
                    let posterPath = result["poster_path"].string
                    
                    //Check if nil
                    if (posterPath != nil) {
                        let poster = imageGetUrl + posterPath!
                        movie.poster = poster
                    } else {
                        movie.poster = "https://s-media-cache-ak0.pinimg.com/564x/3d/32/27/3d32271e87fc2ee5f44f1a0fe189c804.jpg"
                    }
                    let backdropPath = result["backdrop_path"].string
                    
                    //Check if nil
                    if (backdropPath != nil) {
                        let backdrop = imageGetUrl + backdropPath!
                        movie.backdrop = backdrop
                    } else {
                        movie.backdrop = "https://s-media-cache-ak0.pinimg.com/564x/3d/32/27/3d32271e87fc2ee5f44f1a0fe189c804.jpg"
                    }
                   // var casts = [Actor]()
                    movies.append(movie)
                }
            }
            if movies.count == 0 {
                completion(true, movies)
            }else {
                completion(false, movies)
            }
        }
    }
    
        
}


