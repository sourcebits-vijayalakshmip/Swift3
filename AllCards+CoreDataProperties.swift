//
//  AllCards+CoreDataProperties.swift
//  Swift3
//
//  Created by Vijayalakshmi Pulivarthi on 21/09/16.
//  Copyright © 2016 sourcebits. All rights reserved.
//

import Foundation
import CoreData


extension AllCards {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AllCards> {
        return NSFetchRequest<AllCards>(entityName: "AllCards");
    }

    @NSManaged public var name: String?

}
