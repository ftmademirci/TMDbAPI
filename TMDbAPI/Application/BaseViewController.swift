//
//  BaseViewController.swift
//  TMDbAPI
//
//  Created by Fatma Demirci on 20.10.2020.
//

import UIKit
import SDWebImage

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar()
        
        self.view.backgroundColor = UIColor(hexString: Constants.colorSecondary)
    }
    
    func navigationBar() {
        let navBar = self.navigationController?.navigationBar
        navBar?.barTintColor = UIColor(hexString: Constants.colorPrimary)
        navBar?.isTranslucent = true
        navBar?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    func hideKeyboardOnTap(_ selector: Selector) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: selector)
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func gotoMovieDetail(movieId: Int) {
        let movieDetailViewController = MovieDetailViewController(nibName: "MovieDetailViewController", bundle: nil)
        movieDetailViewController.movieId = movieId

        self.navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
    
    func gotoPersonDetail(personId: Int) {
        let personDetailViewController = PersonDetailViewController(nibName: "PersonDetailViewController", bundle: nil)
        personDetailViewController.personId = personId
        self.navigationController?.pushViewController(personDetailViewController, animated: true)
    }
}
