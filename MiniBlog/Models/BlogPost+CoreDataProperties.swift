//
//  BlogPost+CoreDataProperties.swift
//  
//
//  Created by Paolo Miguel Cruz on 10/6/15.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension BlogPost {

    @NSManaged var title: String?
    @NSManaged var content: String?
    @NSManaged var date: NSDate?
    @NSManaged var blogpost_author: Author?

}
