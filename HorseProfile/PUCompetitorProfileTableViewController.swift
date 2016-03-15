//
//  PUCompetitorProfileTableViewController.swift
//  HorseProfile
//
//  Created by Andyy Hope on 9/03/2016.
//  Copyright © 2016 Punters. All rights reserved.
//

import UIKit

protocol PUCompetitorProfileTableViewControllerDelegate: class {
    func competitorProfileTableViewDidScroll(tableView: UITableView)
    func competitorProfileTableViewDidLoad(tableView: UITableView)
}

class PUCompetitorProfileTableViewController: UITableViewController {

    weak var controllerDelegate: PUCompetitorProfileTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerDelegate?.competitorProfileTableViewDidLoad(tableView)
        prepareTableView()
    }
    
    private func prepareTableView() {
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        tableView.backgroundColor = .clearColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .min
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        cell.textLabel?.text = "Hello World"
        return cell
    }

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) { }

}


extension PUCompetitorProfileTableViewController {
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        controllerDelegate?.competitorProfileTableViewDidScroll(tableView)
    }
}