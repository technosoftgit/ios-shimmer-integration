//
//  SourceDB+CoreDataProperties.swift

//
//  Created by Zain Arshad on 08/02/2019.
//  Copyright © 2019 Technosoft Solutions. All rights reserved.
//
//

import Foundation
import CoreData


extension SourceDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SourceDB> {
        return NSFetchRequest<SourceDB>(entityName: "SourceDB")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var steps: Int16

}
