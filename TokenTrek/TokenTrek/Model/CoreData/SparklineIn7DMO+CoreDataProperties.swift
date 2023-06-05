//
//  SparklineIn7DMO+CoreDataProperties.swift
//  
//
//  Created by Artyom Tabachenko on 22.05.2023.
//
//

import Foundation
import CoreData

extension SparklineIn7DMO {

    @nonobjc class func fetchRequest() -> NSFetchRequest<SparklineIn7DMO> {
        NSFetchRequest<SparklineIn7DMO>(entityName: "SparklineIn7D")
    }

    @NSManaged var price: [Float]?
    @NSManaged var sparklineIn7D: SparklineIn7DMO?

}
