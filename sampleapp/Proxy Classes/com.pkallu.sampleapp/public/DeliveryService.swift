// # Proxy Compiler 17.5.3-9e1425-20170523

import Foundation
import SAPOData

open class DeliveryService<Provider: DataServiceProvider>: DataService<Provider> {

    public override init(provider: Provider) {
        super.init(provider: provider)
        self.provider.metadata = DeliveryServiceMetadata.document
    }

    open func deliveryStatus(query: DataQuery = DataQuery()) throws -> Array<DeliveryStatusType> {
        return try DeliveryStatusType.array(from: self.executeQuery(query.from(DeliveryServiceMetadata.EntitySets.deliveryStatus)).entityList())
    }

    open func deliveryStatus(query: DataQuery = DataQuery(), completionHandler: @escaping(Array<DeliveryStatusType>?, Error?) -> Void) -> Void {
        self.addBackgroundOperation {
            do {
                let result: Array<DeliveryStatusType> = try self.deliveryStatus(query: query)
                OperationQueue.main.addOperation {
                    completionHandler(result, nil)
                }
            }
            catch let error {
                OperationQueue.main.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func packages(query: DataQuery = DataQuery()) throws -> Array<PackagesType> {
        return try PackagesType.array(from: self.executeQuery(query.from(DeliveryServiceMetadata.EntitySets.packages)).entityList())
    }

    open func packages(query: DataQuery = DataQuery(), completionHandler: @escaping(Array<PackagesType>?, Error?) -> Void) -> Void {
        self.addBackgroundOperation {
            do {
                let result: Array<PackagesType> = try self.packages(query: query)
                OperationQueue.main.addOperation {
                    completionHandler(result, nil)
                }
            }
            catch let error {
                OperationQueue.main.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }
}
