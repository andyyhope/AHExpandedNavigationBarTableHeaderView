//
//  CompetitorProfileHeaderViewController.swift
//  HorseProfile
//
//  Created by Andyy Hope on 9/03/2016.
//  Copyright © 2016 Punters. All rights reserved.
//

import UIKit


class PUCompetitorProfileHeaderViewController: UIViewController {
    
    @IBOutlet var avatarImageView: UIImageView! { didSet {
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width / 2
        avatarImageView.clipsToBounds = true
        }
    }
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var trainerLabel: UILabel!
    @IBOutlet var informationLabel: UILabel!
    
    @IBOutlet var avatarImageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet var nameLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet var trainerLabelTopConstraint: NSLayoutConstraint!
    
    lazy var nameLabelTopConstraintDefault: CGFloat = self.nameLabelTopConstraint.constant
    lazy var trainerLabelTopConstraintDefault: CGFloat = self.trainerLabelTopConstraint.constant
    lazy var avatarImageViewTopConstraintDefault: CGFloat = self.avatarImageViewTopConstraint.constant
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clearColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}