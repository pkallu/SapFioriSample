// # Proxy Compiler 17.5.3-9e1425-20170523

import Foundation
import SAPOData

open class PackagesType: EntityValue {
    public static let packageID: Property = DeliveryServiceMetadata.EntityTypes.packagesType.property(withName: "PackageID")

    public static let name: Property = DeliveryServiceMetadata.EntityTypes.packagesType.property(withName: "Name")

    public static let description: Property = DeliveryServiceMetadata.EntityTypes.packagesType.property(withName: "Description")

    public static let price: Property = DeliveryServiceMetadata.EntityTypes.packagesType.property(withName: "Price")

    public static let deliveryStatus: Property = DeliveryServiceMetadata.EntityTypes.packagesType.property(withName: "DeliveryStatus")

    public init() {
        super.init(type: DeliveryServiceMetadata.EntityTypes.packagesType)
    }

    open class func array(from: EntityValueList) -> Array<PackagesType> {
        return ArrayConverter.convert(from.toArray(), Array<PackagesType>())
    }

    open func copy() -> PackagesType {
        return CastRequired<PackagesType>.from(self.copyEntity())
    }

    open var deliveryStatus: Array<DeliveryStatusType> {
        get {
            return ArrayConverter.convert(EntityValueList.castRequired(self.dataValue(for: PackagesType.deliveryStatus)).toArray(), Array<DeliveryStatusType>())
        }
        set(value) {
            PackagesType.deliveryStatus.setEntityList(in: self, to: EntityValueList.fromArray(ArrayConverter.convert(value, Array<EntityValue>())))
        }
    }

    open var description: String? {
        get {
            return StringValue.optional(self.dataValue(for: PackagesType.description))
        }
        set(value) {
            self.setDataValue(for: PackagesType.description, to: StringValue.of(optional: value))
        }
    }

    open class func key(packageID: String) -> EntityKey {
        return EntityKey().with(name: "PackageID", value: StringValue.of(packageID))
    }

    open var name: String? {
        get {
            return StringValue.optional(self.dataValue(for: PackagesType.name))
        }
        set(value) {
            self.setDataValue(for: PackagesType.name, to: StringValue.of(optional: value))
        }
    }

    open var old: PackagesType {
        get {
            return CastRequired<PackagesType>.from(self.oldEntity)
        }
    }

    open var packageID: String {
        get {
            return StringValue.unwrap(self.dataValue(for: PackagesType.packageID))
        }
        set(value) {
            self.setDataValue(for: PackagesType.packageID, to: StringValue.of(value))
        }
    }

    open var price: BigDecimal? {
        get {
            return DecimalValue.optional(self.dataValue(for: PackagesType.price))
        }
        set(value) {
            self.setDataValue(for: PackagesType.price, to: DecimalValue.of(optional: value))
        }
    }
}
