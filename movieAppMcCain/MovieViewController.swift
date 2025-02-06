//
//  MovieViewController.swift
//  movieAppMcCain
//
//  Created by SEAN MCCAIN on 1/22/25.
//

import UIKit

class MovieViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var RTRating: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    var id0 = ""
    var plot0 = ""
    var title0 = ""
    var rated0 = ""
    var year0 = ""
    var runtime0 = ""
    var genre0 = ""
    var ratings0 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let session = URLSession.shared
        
        print(AppData.currentMovieIndex)
        
        let movieURL = URL(string: "http://www.omdbapi.com/?apikey=ee0c467f&type=movie&i=\(AppData.currentMovieIndex)")!

        for movie in AppData.favoriteMovies{
            
            if movie.id == AppData.currentMovieIndex{
                
                favoriteButton.setImage(UIImage(named: "star.fill"), for: .normal)
                break
                
            }
            
        }
        
        let dataTask = session.dataTask(with: movieURL) { data, response, error in
            
            if let e = error{
                
                print("Error: \(e)")
                
            }
            
            else{
                
                if let d = data{
                    
                    //Getting JSON object from the API
                    if let jsonObj = try? JSONSerialization.jsonObject(with: d, options: .fragmentsAllowed) as? NSDictionary{
                        
                        print(jsonObj)
                        
                        if let error = jsonObj.value(forKey: "Error") as? String{
                            
                            DispatchQueue.main.async{
                                
                                //Error Message implementation
                                
                            }
                            
                        }
                        
                        if let id = jsonObj.value(forKey: "imdbID") as? String{
                            
                            DispatchQueue.main.async{
                                
                                self.id0 = id
                                
                            }
                            
                        }
                        
                        if let title = jsonObj.value(forKey: "Title") as? String{
                            
                            DispatchQueue.main.async{
                                
                                self.titleLabel.text = title
                                self.title0 = title
                                
                            }
                            
                        }
                        if let plot = jsonObj.value(forKey: "Plot") as? String{
                            
                            DispatchQueue.main.async{
                                
                                self.descriptionLabel.text = plot
                                self.plot0 = plot
                                
                            }
                            
                        }
                        if let rating = jsonObj.value(forKey: "Rated") as? String{
                            
                            DispatchQueue.main.async{
                                
                                self.ratingLabel.text = rating
                                self.rated0 = rating
                                
                            }
                            
                        }
                        if let year = jsonObj.value(forKey: "Year"){
                            
                            DispatchQueue.main.async{
                                
                                self.yearLabel.text = "\(year)"
                                self.year0 = "\(year)"
                                
                            }
                            
                        }
                        if let runtime = jsonObj.value(forKey: "Runtime") as? String{
                            
                            DispatchQueue.main.async{
                                
                                self.runtimeLabel.text = runtime
                                self.runtime0 = runtime
                                
                            }
                            
                        }
                        if let genre = jsonObj.value(forKey: "Genre") as? String{
                            
                            DispatchQueue.main.async{
                                
                                self.genreLabel.text = genre
                                self.genre0 = genre
                                
                            }
                            
                        }
                        if let ratings = jsonObj.value(forKey: "Ratings") as? [NSDictionary]{
                            
                            if let rt = ratings[1].value(forKey: "Value"){
                                
                                DispatchQueue.main.async{
                                    
                                    self.RTRating.text = "\(rt)"
                                    self.ratings0 = "\(rt)"
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
        dataTask.resume()
    }
    
    @IBAction func favoriteButtonAction(_ sender: Any) {
        
        if(favoriteButton.image(for: .normal) == UIImage(systemName: "star.fill")){
            
            favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
            if(AppData.favoriteMovies.count > 0){
                
                for i in 0...AppData.favoriteMovies.count{
                    
                    if(AppData.favoriteMovies[i].id == AppData.currentMovieIndex){
                        
                        AppData.favoriteMovies.remove(at: i)
                        break
                        
                    }
                    
                }
                
            }
            
            print("---\(title0) removed from favorites---")
            
        }
        else{
            
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            AppData.favoriteMovies.append(Movie(id: id0, title: title0, plot: plot0, rated: rated0, runtime: runtime0, genre: genre0, rottenTomatoes: ratings0, year: year0))
            
            print("---\(title0) added to favorites---")
            
            
        }
        
    }
    
}
