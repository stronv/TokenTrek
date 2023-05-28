//
//  CoreDataManager.swift
//  TokenTrek
//
//  Created by Artyom Tabachenko on 21.05.2023.
//

import Foundation
import CoreData

class CoreDataManager: NSObject {

    private override init() {
        super.init()
    }

    static let _shared = CoreDataManager()

    class func shared() -> CoreDataManager {
        return _shared
    }

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TokenTrek")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    lazy var viewContext = {
        return self.persistentContainer.viewContext
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func prepare(dataForSaving: [Coin]){
        let fetchRequest: NSFetchRequest<CoinMO> = CoinMO.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let result = try viewContext.fetch(fetchRequest)
            for data in result as [NSManagedObject] {
                viewContext.delete(data)
            }
            try viewContext.save()
        } catch {
            print("Failed")
        }
        _ = dataForSaving.map { self.createEntityFrom(coin: $0) }
        saveContext()
    }

    private func createEntityFrom(coin: Coin) -> CoinMO? {
        let id = coin.id
        let symbol = coin.symbol
        let name = coin.name
        let image = coin.image
        let currentPrice = coin.currentPrice
        let marketCapRank = coin.marketCapRank

        guard let marketCap = coin.marketCap,
              let totalVolume = coin.totalVolume,
              let priceChangePercentage24H = coin.priceChangePercentage24H,
              let sparklineIn7D = coin.sparklineIn7D
        else {
            return nil
        }
        let coinMo = CoinMO(context: self.viewContext)
        
        coinMo.id = id
        coinMo.name = name
        coinMo.symbol = symbol
        coinMo.image = image
        coinMo.currentPrice = currentPrice
        coinMo.marketCap = marketCap
        coinMo.marketCapRank = Int16(marketCapRank)
        coinMo.totalVolume = totalVolume
        coinMo.priceChangePercentage24H = priceChangePercentage24H
        coinMo.sparklineIn7D = convetSparklineToSparklineMO(sparkLine: sparklineIn7D)
        
        return coinMo
    }
    
    func fetchCoinsFromCoreData() -> [Coin] {
        let fetchRequest: NSFetchRequest<CoinMO> = CoinMO.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false

        do {
            let result = try viewContext.fetch(fetchRequest)
            var coins: [Coin] = []
            for coin in result as [NSManagedObject] {
                let id = coin.value(forKey: "id") as? String ?? ""
                let symbol = coin.value(forKey: "symbol") as? String ?? ""
                let name = coin.value(forKey: "name") as? String ?? ""
                let image = coin.value(forKey: "image") as? String ?? ""
                let currentPrice = coin.value(forKey: "currentPrice") as? Double ?? 0.0
                let marketCapRank = coin.value(forKey: "marketCapRank") as? Int ?? 0
                let marketCap = coin.value(forKey: "marketCap") as? Double
                let totalVolume = coin.value(forKey: "totalVolume") as? Double
                let high24H = coin.value(forKey: "high24H") as? Double
                let low24H = coin.value(forKey: "low24H") as? Double
                let priceChange24H = coin.value(forKey: "priceChange24H") as? Double
                let priceChangePercentage24H = coin.value(forKey: "priceChangePercentage24H") as? Double
                let marketCapChange24H = coin.value(forKey: "marketCapChange24H") as? Double
                let marketCapChangePercentage24H = coin.value(forKey: "marketCapChangePercentage24H") as? Double
                let ath = coin.value(forKey: "ath") as? Double
                let athDate = coin.value(forKey: "athDate") as? String
                let atl = coin.value(forKey: "atl") as? Double
                let atlDate = coin.value(forKey: "atlDate") as? String
                let lastUpdated = coin.value(forKey: "lastUpdated") as? String
                guard let sparkLineValue = coin.value(forKey: "sparklineIn7D") as? SparklineIn7DMO  else { return [] }
                let sparklineIn7D = convertSparklineMOToSparkline(sparklineMO: sparkLineValue)
                let priceChangePercentage24HInCurrency = coin.value(forKey: "priceChangePercentage24HInCurrency") as? Double
            
                let coin = Coin(
                    id: id,
                    symbol: symbol,
                    name: name,
                    image: image,
                    currentPrice: currentPrice,
                    marketCapRank: marketCapRank,
                    marketCap: marketCap,
                    totalVolume: totalVolume,
                    high24H: high24H,
                    low24H: low24H,
                    priceChange24H:
                        priceChange24H,
                    priceChangePercentage24H: priceChangePercentage24H,
                    marketCapChange24H: marketCapChange24H,
                    marketCapChangePercentage24H: marketCapChangePercentage24H,
                    ath: ath,
                    athDate: athDate,
                    atl: atl,
                    atlDate: atlDate,
                    lastUpdated: lastUpdated,
                    sparklineIn7D: sparklineIn7D,
                    priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency
                )
                coins.append(coin)
            }
            return coins
        } catch {
            print("Failed")
            return []
        }
    }
    
    private func convertSparklineMOToSparkline(sparklineMO: SparklineIn7DMO) -> SparklineIn7D {
        let price = sparklineMO.price
        let sparklineIn7D = SparklineIn7D(price: price)
        return sparklineIn7D
    }
    
    private func convetSparklineToSparklineMO(sparkLine: SparklineIn7D) -> SparklineIn7DMO? {
        let price = sparkLine.price
        let sparklineIn7DMO = SparklineIn7DMO(context: self.viewContext)
        sparklineIn7DMO.price = price
        return sparklineIn7DMO
    }
}
