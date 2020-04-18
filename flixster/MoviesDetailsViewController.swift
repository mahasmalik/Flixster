//
//  MoviesDetailsViewController.swift
//  flixster
//
//  Created by Maha Malik on 4/16/20.
//  Copyright © 2020 Maha Malik. All rights reserved.
//

import UIKit
import AlamofireImage

class MoviesDetailsViewController: UIViewController {

    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    var movie: [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        tapGestureRecognizer.numberOfTouchesRequired = 1
        posterView.isUserInteractionEnabled = true
        posterView.addGestureRecognizer(tapGestureRecognizer)

        // Do any additional setup after loading the view.
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        
        dateLabel.text = movie["release_date"] as? String
        dateLabel.sizeToFit()
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        
        posterView.af_setImage(withURL: posterUrl!)
        
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)!

        backdropView.af_setImage(withURL: backdropUrl)
    }
    
/*
     MARK: - Navigation

     In a storyboard-based application, you will often want to do a little preparation before navigation
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         //Get the new view controller using segue.destination.
         //Pass the selected object to the new view controller.
        
        //pass the selected movie to the details view controller
        let trailerViewController = segue.destination as! MovieTrailerViewController //connect them
        trailerViewController.movie = movie //movie that we found is set now
        trailerViewController.id = movie["id"] as! Int
        
        //not selected still when we go back
        //tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func didTap(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
        performSegue(withIdentifier: "firstSegue", sender: nil)
    }
    
}
