//
//  ViewController.swift
//  HorseProfile
//
//  Created by Andyy Hope on 9/03/2016.
//  Copyright © 2016 Punters. All rights reserved.
//

import UIKit

extension PUCompetitorProfileContainerViewController {
    private enum Segue : String {
        case Header, TableView
    }
}

class PUCompetitorProfileContainerViewController: UIViewController {

    let offsetForNameLabelToReachNavigationBarTitleView: CGFloat = 84
    
    @IBOutlet var visualEffectView: UIVisualEffectView!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var headerContainerView: UIView!
    @IBOutlet var tableContainerView: UIView!
    
    @IBOutlet var profileImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var headerContainerViewTopConstraint: NSLayoutConstraint!
    
    lazy var headerContainerViewDefaultHeight: CGFloat = self.headerContainerView.frame.height
    lazy var profileImageViewDefaultHeight : CGFloat = self.profileImageView.frame.size.height
    
    var headerViewController: PUCompetitorProfileHeaderViewController?
    var tableViewController: PUCompetitorProfileTableViewController?
    
    var navigationBarImageSet = false
    
    var topBarsHeight: CGFloat {
        let navigationBarHeight = navigationController?.navigationBar.frame.size.height ?? 44
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.size.height
        return navigationBarHeight + statusBarHeight
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareNavigationController()
    }
    
    private func prepareNavigationController() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = .clearColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let
            identifier = segue.identifier,
            container = Segue(rawValue: identifier)
        else { return }
        
        switch container {
        case .Header:
            if let viewController = segue.destinationViewController as? PUCompetitorProfileHeaderViewController {
                headerViewController = viewController
            }
            
        case .TableView:
            if let viewController = segue.destinationViewController as? PUCompetitorProfileTableViewController {
                tableViewController = viewController
                tableViewController?.controllerDelegate = self
            }
        }
    }
}

extension PUCompetitorProfileContainerViewController : PUCompetitorProfileTableViewControllerDelegate {
    func competitorProfileTableViewDidScroll(tableView: UITableView) {
        updateVisualEffectViewForTableViewOffset(tableView.contentOffset.y)
        updateAvatarForTableViewOffset(tableView.contentOffset.y)
        
        updateTableViewForTableViewOffset(tableView)
        updateHeaderViewForTableViewOffset(tableView)
        
        updateHeaderViewForTableViewOffset(tableView.contentOffset.y)
        updateHeaderViewMasksForTableViewOffset(tableView.contentOffset.y)
    }
    
    private func updateVisualEffectViewForTableViewOffset(offset: CGFloat) {
        let offset = offset * -1
        let percentage = 1 - (((offset - headerContainerViewDefaultHeight) / 100) * 2)

        headerContainerView.alpha = percentage
        visualEffectView.alpha = percentage
    }
    
    private func updateAvatarForTableViewOffset(offset: CGFloat) {
        let offset = offset * -1
        
        if offset < 180 {
            UIView.animateWithDuration(0.3, animations: { [weak self] () -> Void in
                self?.headerViewController?.avatarImageView.alpha = 0
            })
        }
        else {
            UIView.animateWithDuration(0.3, animations: { [weak self] () -> Void in
                self?.headerViewController?.avatarImageView.alpha = 1
            })
        }
    }
    
    private func updateTableViewForTableViewOffset(tableView: UITableView) {
        let offset = tableView.contentOffset.y * -1
        if  offset <= topBarsHeight && navigationBarImageSet == false {
            navigationBarImageSet = true
            
            // Mask View
            let frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: topBarsHeight)
            let maskRect = CGRect(x: 0, y: frame.size.height, width: frame.size.width, height: view.frame.size.height - frame.size.height)
            let maskLayer = CAShapeLayer()
            let maskPath = CGPathCreateWithRect(maskRect, nil)
            maskLayer.path = maskPath
            tableContainerView.layer.mask = maskLayer
            
        }
        else if offset > topBarsHeight && navigationBarImageSet {
            tableContainerView.layer.mask = nil
            navigationBarImageSet = false
        }
    }
    
    private func updateHeaderViewForTableViewOffset(tableView: UITableView) {
        let offset = tableView.contentOffset.y * -1
        
        // Adjust the Header container view dimensions
        if offset > profileImageViewDefaultHeight {
            headerContainerViewTopConstraint.constant = 0
            profileImageViewHeightConstraint.constant = profileImageViewDefaultHeight - tableView.contentOffset.y - profileImageViewDefaultHeight
        }
        else {
            headerContainerViewTopConstraint.constant = (profileImageViewDefaultHeight + tableView.contentOffset.y) * -1
        }
    }
    
    private func updateHeaderViewForTableViewOffset(offset: CGFloat) {
        
        guard let viewController = headerViewController else { return }
        
        let offset = ((offset * -1) - headerContainerViewDefaultHeight) * -1

        if offset >= offsetForNameLabelToReachNavigationBarTitleView {
            let nameLabelOffset = viewController.nameLabelTopConstraintDefault + offset - offsetForNameLabelToReachNavigationBarTitleView
            viewController.nameLabelTopConstraint.constant = nameLabelOffset
        }
        else if offset < 0 {
            viewController.nameLabelTopConstraint.constant = viewController.nameLabelTopConstraintDefault
        }
    }
    
    private func updateHeaderViewMasksForTableViewOffset(offset: CGFloat) {
        
        let offset = ((offset * -1) - headerContainerViewDefaultHeight) * -1
        
        let frame = headerContainerView.frame
        var maskRect: CGRect = .zero
        
        if offset > headerContainerViewDefaultHeight - topBarsHeight {
            maskRect = CGRect(x: 0, y: offset, width: frame.size.width, height: topBarsHeight)
        }
        else if offset > offsetForNameLabelToReachNavigationBarTitleView {
            maskRect = CGRect(x: 0, y: 0, width: frame.size.width, height: headerContainerView.frame.size.height)
        }
        
        if maskRect != CGRect.zero {
            let maskLayer = CAShapeLayer()
            let maskPath = CGPathCreateWithRect(maskRect, nil)
            maskLayer.path = maskPath
            headerContainerView.layer.mask = maskLayer
        }
        else {
            headerContainerView.layer.mask = nil
        }
    }
    
    func competitorProfileTableViewDidLoad(tableView: UITableView) {
        tableView.contentInset.top = profileImageView.frame.size.height
    }
}