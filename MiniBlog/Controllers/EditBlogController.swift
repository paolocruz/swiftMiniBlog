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
    var blogPostTitle: String?
    var blogPostContent: String?
    var blogAuthor: String?
    var blogPostDate: NSDate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load Targeted Xibs
        self.loadXibName("EditBlogView")
        self.editBlogView = (self.view as! EditBlogView)
        
        // Initialize UI Elements
        self.initializeNavigationBar()
        self.editBlogView?.blogTitleTextField.text = blogPostTitle
        self.editBlogView?.blogPostTextView.text = blogPostContent
        
    }
    
    // MARK: CoreData Methods
    func updateBlog(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "BlogPost")
        fetchRequest.predicate = NSPredicate(format: "date = %@", blogPostDate!)
        
        do {
            let fetchResults = try appDelegate.managedObjectContext.executeFetchRequest(fetchRequest) as? [BlogPost]
            if fetchResults!.count != 0{
                
                let managedObject = fetchResults![0]
                managedObject.setValue(self.editBlogView?.blogTitleTextField.text, forKey: "title")
                managedObject.setValue(self.editBlogView?.blogPostTextView.text, forKey: "content")
                
                try managedContext.save()
            }
        }
        catch let error as NSError {
            print("\(error)")
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: Controller Initializers
    
    func initializeNavigationBar(){
        
        let editBlogButtonItem = UIBarButtonItem(title: "Update Post", style: .Plain, target: self, action: Selector("updateBlog"))
        
        self.navigationItem.rightBarButtonItem = editBlogButtonItem
        
    }
    
}