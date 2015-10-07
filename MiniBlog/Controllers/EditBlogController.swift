//
//  EditBlogController.swift
//  MiniBlog
//
//  Created by Paolo Miguel Cruz on 10/6/15.
//  Copyright © 2015 Seer Technologies, Inc. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class EditBlogController: BaseController{
    
    var editBlogView: EditBlogView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load Targeted Xibs
        self.loadXibName("EditBlogView")
        self.editBlogView = (self.view as! EditBlogView)
        
        // Initialize UI Elements
        self.initializeNavigationBar()
        
    }
    
    // MARK: CoreData Methods
    func updateBlog(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("BlogPost",
            inManagedObjectContext:managedContext)
        let blogPost:BlogPost = BlogPost(entity: entity!,
            insertIntoManagedObjectContext: managedContext)
        blogPost.title = self.editBlogView?.blogTitleTextField.text
        blogPost.content = self.editBlogView?.blogPostTextView.text
        blogPost.date = NSDate()
        
        let authEntity =  NSEntityDescription.entityForName("Author",
            inManagedObjectContext:managedContext)
        let auth:Author = Author(entity: authEntity!,
            insertIntoManagedObjectContext: managedContext)
        auth.name = SessionManager.sharedInstance.sessionName
        blogPost.blogpost_author = auth
        
        do {
            try managedContext.save()
            self.navigationController?.popViewControllerAnimated(true)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
    }
    
    // MARK: Controller Initializers
    
    func initializeNavigationBar(){
        
        let editBlogButtonItem = UIBarButtonItem(title: "Post", style: .Plain, target: self, action: Selector("updateBlog"))
        
        self.navigationItem.rightBarButtonItem = editBlogButtonItem
        
    }
    
}