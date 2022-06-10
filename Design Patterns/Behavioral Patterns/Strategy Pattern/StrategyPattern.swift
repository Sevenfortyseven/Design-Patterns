//
//  StrategyPattern.swift
//  Design Patterns
//
//  Created by aleksandre on 10.06.22.
//

/* • The strategy pattern defines a family of interchangeable objects that can be set or switched at runtime.
   • This pattern has three parts: an object using a strategy, a strategy protocol, and a family of strategy objects.
   • The strategy pattern is similar to the delegation pattern: Both patterns use a protocol for flexibility. Unlike the delegation pattern, however, strategies are meant to be switched at runtime, whereas delegates are usually fixed. */

import UIKit


// MARK: -- Strategy Protocol
public protocol MovieRatingStrategy {
    var ratingServiceName: String { get }
    
    func fetchRating(for MovieTitle: String, success: (_ rating: String, _ review: String) -> Void)
}


// MARK: -- Implementation for RottenTomatoesClient -- Concrete strategy #1
public class RottenTomatoesClient: MovieRatingStrategy {
    public var ratingServiceName: String = "Rotten Tomatoes"
    
    public func fetchRating(for MovieTitle: String, success: (String, String) -> Void) {
        // Do some networking
    }
    
}

// MARK: -- Implementation for IMDBClient -- Concrete strategy #2
public class IMDBClient: MovieRatingStrategy {
    public var ratingServiceName: String = "IMDB"
    
    public func fetchRating(for MovieTitle: String, success: (String, String) -> Void) {
        // Do some networking
    }
    
}

// MARK: -- Object Using A Strategy
public class MovieRatingViewController: UIViewController {
    
    // MARK: - Properties
    public var movieRatingClient: MovieRatingStrategy!
    
    //MARK: - Outlets
    @IBOutlet public var movieTitleTextField: UITextField!
    @IBOutlet public var ratingServiceLabelText: UILabel!
    @IBOutlet public var ratingLabel: UILabel!
    @IBOutlet public var reviewLabel: UILabel!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        ratingServiceLabelText.text = movieRatingClient.ratingServiceName
    }
    
    //MARK: - Actions
    @IBAction public func searchButtonPressed(sender: Any) {
        guard let movieTitle = movieTitleTextField.text else { return }
        movieRatingClient.fetchRating(for: movieTitle) { [unowned self] rating, review in
            ratingLabel.text = rating
            reviewLabel.text = review
        }
    }
}
