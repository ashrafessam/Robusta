//
//  RepositoriesCell.swift
//  RobustaTask
//
//  Created by Ashraf Essam on 16/04/2021.
//

import UIKit

class RepositoriesCell: UITableViewCell {
    @IBOutlet weak var repoAvatar: CustomImageView!
    @IBOutlet weak var ownerName: UILabel!
    @IBOutlet weak var repoName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureText(repoName: String,ownerName: String ){
        self.ownerName.text = ownerName
        self.repoName.text = repoName
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
