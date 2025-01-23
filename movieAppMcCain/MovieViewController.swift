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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let session = URLSession.shared
        
        let movieURL = URL(string: "http://www.omdbapi.com/?apikey=ee0c467f&type=movie&i=\(AppData.currentMovieIndex)")!
        
        if(AppData.favoriteMovies.count > 0){
            
            for i in 0...AppData.favoriteMovies.count-1{
                
                if AppData.favoriteMovies[i] == AppData.currentMovieIndex{
                    
                    favoriteButton.setImage(UIImage(named: "star.fill"), for: .normal)
                    break
                    
                }
                
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
                        
                        if let title = jsonObj.value(forKey: "Title") as? String{
                            
                            DispatchQueue.main.async{
                                
                                self.titleLabel.text = title
                                
                            }
                            
                        }
                        if let plot = jsonObj.value(forKey: "Plot") as? String{
                            
                            DispatchQueue.main.async{
                                
                                self.descriptionLabel.text = plot
                                
                            }
                            
                        }
                        if let rating = jsonObj.value(forKey: "Rated") as? String{
                            
                            DispatchQueue.main.async{
                                
                                self.ratingLabel.text = rating
                                
                            }
                            
                        }
                        if let year = jsonObj.value(forKey: "Year"){
                            
                            DispatchQueue.main.async{
                                
                                self.yearLabel.text = "\(year)"
                                
                            }
                            
                        }
                        if let runtime = jsonObj.value(forKey: "Runtime"){
                            
                            DispatchQueue.main.async{
                                
                                self.runtimeLabel.text = "\(runtime)"
                                
                            }
                            
                        }
                        if let runtime = jsonObj.value(forKey: "Runtime"){
                            
                            DispatchQueue.main.async{
                                
                                self.runtimeLabel.text = "\(runtime)"
                                
                            }
                            
                        }
                        if let genre = jsonObj.value(forKey: "Genre"){
                            
                            DispatchQueue.main.async{
                                
                                self.genreLabel.text = "\(genre)"
                                
                            }
                            
                        }
                        if let ratings = jsonObj.value(forKey: "Ratings") as? [NSDictionary]{
                            
                            if let rt = ratings[1].value(forKey: "Value"){
                                
                                DispatchQueue.main.async{
                                    
                                    self.RTRating.text = "\(rt)"
                                    
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
        
        favoriteButton.setImage(UIImage(named: "star.fill"), for: .normal)
        
    }
    
}
