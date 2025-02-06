//
//  ViewController.swift
//  movieAppMcCain
//
//  Created by SEAN MCCAIN on 1/16/25.
//

import UIKit

class AppData{
    
    static var movies : [NSDictionary] = []
    static var currentMovieIndex = ""
    static var favoriteMovies : [Movie] = []
    
}

class Movie{
    
    var id : String
    var title : String
    var plot : String
    var rated : String
    var runtime : String
    var genre : String
    var rottenTomatoes : String
    var year : String
    
    init(id: String, title: String, plot: String, rated: String, runtime: String, genre: String, rottenTomatoes: String, year: String) {
        self.id = id
        self.title = title
        self.plot = plot
        self.rated = rated
        self.runtime = runtime
        self.genre = genre
        self.rottenTomatoes = rottenTomatoes
        self.year = year
    }
    
}

class ViewController: UIViewController {

    @IBOutlet weak var searchField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func searchButton(_ sender: Any) {
        
        
        
        
        let title = searchField.text
        
        let session = URLSession.shared
        
        let movieURL = URL(string: "http://www.omdbapi.com/?apikey=ee0c467f&type=movie&s=\(title!)")!
        
        let dataTask = session.dataTask(with: movieURL) { data, response, error in
            
            if let e = error{
                
                let alert = UIAlertController(title: "Error", message: "\(e)", preferredStyle: .alert)
                let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
                alert.addAction(dismissAction)
                self.present(alert, animated: true, completion: nil)
                print("Error: \(e)")
         
            }
            
            else{
                
                if let d = data{
                    
                    //Getting JSON object from the API
                    if let jsonObj = try? JSONSerialization.jsonObject(with: d, options: .fragmentsAllowed) as? NSDictionary{
                        
                        print(jsonObj)
                        
                        if let error = jsonObj.value(forKey: "Error") as? String{
                            
                            DispatchQueue.main.async{
                                
                                let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
                                let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
                                alert.addAction(dismissAction)
                                self.present(alert, animated: true, completion: nil)
                                print("Error: \(error)")
                                
                            }
                            
                        }
                        
                        if let search = jsonObj.value(forKey: "Search") as? [NSDictionary]{
                            
                            DispatchQueue.main.async{
                                
                                AppData.movies = search
                                
                                self.performSegue(withIdentifier: "movieSegue", sender: nil)
                                
                                print("\n---------------\n\(AppData.movies[0])")
                                
                            }
                            
                        }
                        
                        
                        
                    }
                    
                }
                
            }
            
        }
        
        dataTask.resume()
        
    }

}

