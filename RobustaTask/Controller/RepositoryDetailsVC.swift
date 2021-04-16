//
//  RepositoryDetailsVC.swift
//  RobustaTask
//
//  Created by Ashraf Essam on 16/04/2021.
//

import UIKit

class RepositoryDetailsVC: UIViewController {
    @IBOutlet weak var creationDateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    
    var repoName: String?
    var repoUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NavigationTile()
        fetchRepoDetails()
        
    }
    
    fileprivate func NavigationTile(){
        guard let title = repoName else { return }
        NavigationTitle(title: title)
    }
    
    private func fetchRepoDetails(){
        guard let url = repoUrl else { return }
        APIManager.shared.fetchReposDetails(url: url) { (result) in
            switch result {
            case .success(let repoDetail):
                DispatchQueue.main.async {
                    self.nameLabel.text = "Name: \(repoDetail.name )"
                    self.locationLabel.text = "Location: \(repoDetail.location ?? "")"
                    self.companyLabel.text = "Company: \(repoDetail.company ?? "")"
                    
                    guard let date = repoDetail.createdAt else { return }
                    let myDate = self.convertStringToDate(date: date)
                    let difference = self.daysBetweenDates(startDate: myDate, endDate: Date())
                    if difference > 6 {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
                        let dateString = dateFormatter.string(from: myDate)
                        self.creationDateLabel.text = "Creation Date:\n\(dateString)"
                    }
                    else {
                        self.creationDateLabel.text = "\(difference) months ago"
                    }
                }
            case .failure(let error):
                print("Failed to fetch repo details", error)
            }
        }
    }
}
