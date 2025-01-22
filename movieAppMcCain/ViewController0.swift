//
//  ViewController0.swift
//  movieAppMcCain
//
//  Created by SEAN MCCAIN on 1/16/25.
//

import UIKit

class ViewController0: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return AppData.movies.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! movieCell
        
        cell.titleLabel.text = "\(AppData.movies[indexPath.row].value(forKey: "Title")!)"
        cell.releaseLabel.text = "\(AppData.movies[indexPath.row].value(forKey: "Year")!)"
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        AppData.currentMovieIndex = AppData.movies[indexPath.row].value(forKey: "imdbID") as! String
        self.performSegue(withIdentifier: "anotherMovieSegue", sender: nil)
        
    }

}
