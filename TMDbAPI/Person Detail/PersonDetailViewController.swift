//
//  PersonDetailViewController.swift
//  TMDbAPI
//
//  Created by Fatma Demirci on 15.10.2020.
//

import UIKit

class PersonDetailViewController: BaseViewController {
    
    var viewModel = PersonDetailViewModel(dependencies: PersonDetailViewModel.Dependencies(api: API()))
    var personId = 0
    
    @IBOutlet var backgroundBlurImage: UIImageView!
    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var personAgeLabel: UILabel!
    @IBOutlet weak var personBiographyLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.getPersonData()
    }
    
    func getPersonData() {
        self.viewModel.getPersonData (personId: personId, success: {
            let item = self.viewModel.person_data
            if let profile_path = item?.profile_path {
                self.personImageView.layer.masksToBounds = true
                self.personImageView.sd_setImage(with: URL(string: Constants.imageUrl + profile_path), placeholderImage: UIImage(named: "placeholder.png"))
                self.backgroundBlurImage.sd_setImage(with: URL(string: Constants.imageUrl + profile_path))
                self.backgroundBlurImage.addBlurEffect()
            }
            
            self.personNameLabel.text = self.viewModel.person_data?.name
            self.title = self.viewModel.person_data?.name
            self.personAgeLabel.text = String(self.viewModel.person_data?.birthday?.prefix(4) ?? "")
            self.personBiographyLabel.text = self.viewModel.person_data?.biography
            
        }) { (error) in
            
        }
    }

}
