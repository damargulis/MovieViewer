//
//  DetailViewController.swift
//  MovieViewer
//
//  Created by Daniel Margulis on 1/30/16.
//  Copyright © 2016 Daniel Margulis. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var infoView: UIView!
    
    
    var movie: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: infoView.frame.origin.y + infoView.frame.size.height)
        
        let title = movie["title"] as? String
        titleLabel.text = title
        
        let overview = movie["overview"] as? String
        overviewLabel.text = overview
        
        print(overviewLabel.frame.size.height)
        
        overviewLabel.sizeToFit()
        infoView.sizeToFit()
        
//        let baseUrl = "http://image.tmdb.org/t/p/w500"
        if let posterPath = movie["poster_path"] as? String{
            
            
//            let imageUrl = NSURL(string: baseUrl + posterPath)
            let smallBaseUrl = "https://image.tmdb.org/t/p/w45"
            let largeBaseUrl = "https://image.tmdb.org/t/p/original"
            
            
            
            let smallImageRequest = NSURLRequest(URL: NSURL(string: smallBaseUrl + posterPath)!)
            let largeImageRequest = NSURLRequest(URL: NSURL(string: largeBaseUrl + posterPath)!)
            
            posterImageView.setImageWithURLRequest(
                smallImageRequest,
                placeholderImage: nil,
                success: { (smallImageRequest, smallImageResponse, smallImage) -> Void in
                    
                    self.posterImageView.alpha = 0.0
                    self.posterImageView.image = smallImage;
                    
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.posterImageView.alpha = 1.0
                        }, completion: { (sucess) -> Void in
                            
                       self.posterImageView.setImageWithURLRequest(
                                largeImageRequest,
                                placeholderImage: smallImage,
                                success: { ( largeImageRequest, largeImageResponse, largeImage) -> Void in
                                    
                                    self.posterImageView.image = largeImage;
                            },
                                failure: { (request, response, error) -> Void in
                                    self.posterImageView.image = nil;
                            })
                    })
                    
                },
                failure: { ( request, response, error) -> Void in
               self.posterImageView.image = nil;
            })
            
//            posterImageView.setImageWithURL(imageUrl!)
        }
        
        
        // Do any additional setup after loading the view.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
