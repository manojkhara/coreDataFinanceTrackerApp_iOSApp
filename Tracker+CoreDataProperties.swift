//
//  Tracker+CoreDataProperties.swift
//  coreDataFinanceTracker
//
//  Created by Manoj 07 on 10/08/22.
//
//

import Foundation
import CoreData


extension Tracker {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tracker> {
        return NSFetchRequest<Tracker>(entityName: "Tracker")
    }

    @NSManaged public var category: String?
    @NSManaged public var amount: Double
    @NSManaged public var infotype: String?

}

extension Tracker : Identifiable {

}
