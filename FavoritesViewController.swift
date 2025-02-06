//
//  FavoritesViewController.swift
//  movieAppMcCain
//
//  Created by SEAN MCCAIN on 1/31/25.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppData.favoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! movieCell0
        
        cell.titleLabel.text = "\(AppData.favoriteMovies[indexPath.row].title)"
        cell.releaseLabel.text = "\(AppData.favoriteMovies[indexPath.row].year)"
        
        return cell
        
    }

}
