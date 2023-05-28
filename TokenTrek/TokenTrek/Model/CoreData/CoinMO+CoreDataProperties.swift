//
//  CoinMO+CoreDataProperties.swift
//  
//
//  Created by Artyom Tabachenko on 22.05.2023.
//
//

import Foundation
import CoreData


extension CoinMO {
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<CoinMO> {
        NSFetchRequest<CoinMO>(entityName: "Coin")
    }
    
    @NSManaged var ath: Double
    @NSManaged var athChangePercentage: Double
    @NSManaged var athDate: String?
    @NSManaged var atl: Double
    @NSManaged var atlChangePercentage: Double
    @NSManaged var atlDate: String?
    @NSManaged var circulatingSupply: Double
    @NSManaged var currentPrice: Double
    @NSManaged var fullyDilutedValuation: Double
    @NSManaged var high24H: Double
    @NSManaged var id: String
    @NSManaged var image: String
    @NSManaged var lastUpdated: String
    @NSManaged var low24H: Double
    @NSManaged var marketCap: Double
    @NSManaged var marketCapChange24H: Double
    @NSManaged var marketCapChangePercentage24H: Double
    @NSManaged var marketCapRank: Int16
    @NSManaged var maxSupply: Double
    @NSManaged var name: String
    @NSManaged var priceChange24H: Double
    @NSManaged var priceChangePercentage24H: Double
    @NSManaged var priceChangePercentage24HInCurrency: Double
    @NSManaged var symbol: String
    @NSManaged var totalSupply: Double
    @NSManaged var totalVolume: Double
    @NSManaged var sparklineIn7D: SparklineIn7DMO?
    
}
