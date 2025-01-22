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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let session = URLSession.shared
        
        let movieURL = URL(string: "http://www.omdbapi.com/?apikey=ee0c467f&type=movie&i=\(AppData.currentMovieIndex)")!
        
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
                        if let year = jsonObj.value(forKey: "Year") as? Int{
                            
                            DispatchQueue.main.async{
                                
                                self.yearLabel.text = "\(year)"
                                
                            }
                            
                        }
                        
                        
                        
                    }
                    
                }
                
            }
            
        }
        
        dataTask.resume()
    }
    

}
