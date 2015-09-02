//
//  NewsTableTableViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Tao Liu on 9/1/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Alamofire

class NewsTableTableViewController: UITableViewController{

    let itemBaseURL = "https://hacker-news.firebaseio.com/v0/item/"
    var topStoryIDs: JSON! = []
    var topStories : [StoryObject] = []
    let topStoryURl = "https://hacker-news.firebaseio.com/v0/topstories.json"
    
    
    @IBAction func searchButtonDidTouch(sender: UIBarButtonItem) {
        
    }
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getTopStoriesIDs()
        
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        tableView.estimatedRowHeight = 130
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        //println(topStoryIDs[0])
        //fetchTopStories(topStoryIDs[0])
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        println("row count is \(self.topStories.count)")
        return topStories.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StoryCell", forIndexPath: indexPath) as! StoryTableViewCell
        //println(indexPath.row)
        var storyObj = topStories[indexPath.row]
        
        return configureCell(storyObj, cell: cell)
    }
    
    func configureCell(storyObject : StoryObject, cell : StoryTableViewCell) -> StoryTableViewCell{
        
        cell.sourceLabel.text = storyObject.source
        cell.timeLabel.text = "7h"
        cell.titleLabel.text = storyObject.title
        //cell.titleLabel.numberOfLines = 0
        //cell.titleLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        cell.authorLabel.text = storyObject.author
        cell.shareButton.setTitle("0", forState: .Normal)
        
        var commentCount = toString(storyObject.commentCount)
        cell.commentButton.setTitle(commentCount, forState: .Normal)
        
        cell.favouriteButton.setTitle("0", forState: .Normal)
        
        return cell
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    //MARK: Alamofire methods
    func getTopStoriesIDs(){
        //var topStoryIDs: JSON! = []
        Alamofire.request(.GET,topStoryURl).responseJSON(){
            (_, _, data, _) in
            
            self.topStoryIDs = JSON(data ?? [])
            
            for var i = 0; i < 30; ++i {
                var id = self.topStoryIDs[i]
                self.fetchTopStories(id)
                println("i is \(i)")
            }
            
            
            
            println("id count is \(self.topStories.count)")
        }
    }
    func fetchTopStories(storyID: JSON!){
        
        let id = storyID.int ?? 0
        println("id is \(id)")
        let URLString = itemBaseURL + toString(storyID) + ".json"
        println("urlstring is \(URLString)")
        
        
        Alamofire.request(.GET, URLString).responseJSON(){
            (_, _, data, _) in
            
            let story = JSON(data ?? [])
            var storyObject = StoryObject()
            
            storyObject.author = story["by"].string ?? ""
            storyObject.source = story["url"].string ?? ""
            storyObject.time = story["time"].string ?? ""
            storyObject.title = story["title"].string ?? ""
            storyObject.id = story["id"].int ?? 0
            storyObject.commentCount = story["descendants"].int ?? 0
            
            //println("author is \(storyObject.author)")
            self.topStories.append(storyObject)
            if (self.topStories.count == 30){
                self.tableView.reloadData()
            }
        }
        
        
        
        
    }

}
