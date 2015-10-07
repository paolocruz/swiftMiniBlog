//
//  ViewController.swift
//  MiniBlog
//
//  Created by Allister Alambra on 10/6/15.
//  Copyright © 2015 Seer Technologies, Inc. All rights reserved.
//

import UIKit
import CoreData

class HomeController: BaseController, UITableViewDataSource, UITableViewDelegate,GIDSignInUIDelegate{

    var homeView: HomeView?
    var blogPosts:[BlogPost]?
    var row: Int?
    // MARK: Lifecycle method override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load Targeted Xibs
        self.loadXibName("HomeView")
        self.homeView = (self.view as! HomeView)
        self.homeView?.blogTable.dataSource = self
        self.homeView?.blogTable.delegate = self
        
        // Initialize UI Elements
        self.initializeNavigationBar()
        
        // Register Custom TableView Class
        let nibName = UINib(nibName: "BlogPostCell", bundle:nil)
        self.homeView?.blogTable.registerNib(nibName, forCellReuseIdentifier: "BlogPostCell")
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "BlogPost")
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            self.blogPosts = results as? [BlogPost]
            self.homeView?.blogTable.reloadData()
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    // MARK: Segue to AddBlogView
    func addBlogPost(){
        self.performSegueWithIdentifier("HomeToAddBlogSegue", sender: self)
    }
    
    // MARK: Controller Initializers
    func initializeNavigationBar(){
        
        let addBlogButtonItem = UIBarButtonItem(title: "Blog Now!", style: .Plain, target: self, action: Selector("addBlogPost"))
        
        self.navigationItem.rightBarButtonItem = addBlogButtonItem
        
    }

    // MARK: UITableViewDataSource Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.blogPosts!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = self.homeView?.blogTable.dequeueReusableCellWithIdentifier("BlogPostCell", forIndexPath: indexPath) as! BlogPostCell
        
        let blogPost:BlogPost = self.blogPosts![indexPath.row]
        
        cell.blogTitleLabel.text = blogPost.title! + " by " + blogPost.blogpost_author!.name!
        cell.blogPreviewLabel.text = blogPost.content!
        cell.blogDateLabel.text = String(blogPost.date!)
        
        return cell
    }
    
    // MARK: UITableViewDelegate Methods
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return 70.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        row = indexPath.row
        let blogPost:BlogPost = self.blogPosts![indexPath.row]

        if  (blogPost.blogpost_author!.name! == SessionManager.sharedInstance.sessionName){
            self.performSegueWithIdentifier("editBlog", sender: self)
        }
        else{
            let alert = UIAlertController(title: "Alert", message: "You cannot edit the post of other authors", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "editBlog" {
            if let dest:EditBlogController = segue.destinationViewController as? EditBlogController {
                let blogPost:BlogPost = self.blogPosts![row!]
                dest.blogPostDate = blogPost.date!
                dest.blogPostTitle = blogPost.title!
                dest.blogPostContent = blogPost.content!
                dest.blogAuthor = blogPost.blogpost_author!.name!
            }
        }
    }
    
    
    
}

