//
//  Park+CoreDataProperties.swift
//  9lab_task2.2_KlimkoEugene
//
//  Created by MacOSExi on 17.05.24.
//  Copyright © 2024 MacOSExi. All rights reserved.
//
//

import Foundation
import CoreData


extension Park {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Park> {
        return NSFetchRequest<Park>(entityName: "Park")
    }

    @NSManaged public var name: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double

}
