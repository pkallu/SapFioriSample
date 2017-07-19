// # Proxy Compiler 17.5.3-9e1425-20170523

import Foundation
import SAPOData

open class DeliveryStatusType: EntityValue {
    public static let deliveryStatusID: Property = DeliveryServiceMetadata.EntityTypes.deliveryStatusType.property(withName: "DeliveryStatusID")

    public static let packageID: Property = DeliveryServiceMetadata.EntityTypes.deliveryStatusType.property(withName: "PackageID")

    public static let location: Property = DeliveryServiceMetadata.EntityTypes.deliveryStatusType.property(withName: "Location")

    public static let deliveryTimestamp: Property = DeliveryServiceMetadata.EntityTypes.deliveryStatusType.property(withName: "DeliveryTimestamp")

    public static let statusType: Property = DeliveryServiceMetadata.EntityTypes.deliveryStatusType.property(withName: "StatusType")

    public static let selectable: Property = DeliveryServiceMetadata.EntityTypes.deliveryStatusType.property(withName: "Selectable")

    public static let status: Property = DeliveryServiceMetadata.EntityTypes.deliveryStatusType.property(withName: "Status")

    public init() {
        super.init(type: DeliveryServiceMetadata.EntityTypes.deliveryStatusType)
    }

    open class func array(from: EntityValueList) -> Array<DeliveryStatusType> {
        return ArrayConverter.convert(from.toArray(), Array<DeliveryStatusType>())
    }

    open func copy() -> DeliveryStatusType {
        return CastRequired<DeliveryStatusType>.from(self.copyEntity())
    }

    open var deliveryStatusID: String {
        get {
            return StringValue.unwrap(self.dataValue(for: DeliveryStatusType.deliveryStatusID))
        }
        set(value) {
            self.setDataValue(for: DeliveryStatusType.deliveryStatusID, to: StringValue.of(value))
        }
    }

    open var deliveryTimestamp: LocalDateTime? {
        get {
            return LocalDateTime.castOptional(self.dataValue(for: DeliveryStatusType.deliveryTimestamp))
        }
        set(value) {
            self.setDataValue(for: DeliveryStatusType.deliveryTimestamp, to: value)
        }
    }

    open class func key(deliveryStatusID: String) -> EntityKey {
        return EntityKey().with(name: "DeliveryStatusID", value: StringValue.of(deliveryStatusID))
    }

    open var location: String? {
        get {
            return StringValue.optional(self.dataValue(for: DeliveryStatusType.location))
        }
        set(value) {
            self.setDataValue(for: DeliveryStatusType.location, to: StringValue.of(optional: value))
        }
    }

    open var old: DeliveryStatusType {
        get {
            return CastRequired<DeliveryStatusType>.from(self.oldEntity)
        }
    }

    open var packageID: String? {
        get {
            return StringValue.optional(self.dataValue(for: DeliveryStatusType.packageID))
        }
        set(value) {
            self.setDataValue(for: DeliveryStatusType.packageID, to: StringValue.of(optional: value))
        }
    }

    open var selectable: Int? {
        get {
            return IntValue.optional(self.dataValue(for: DeliveryStatusType.selectable))
        }
        set(value) {
            self.setDataValue(for: DeliveryStatusType.selectable, to: IntValue.of(optional: value))
        }
    }

    open var status: String? {
        get {
            return StringValue.optional(self.dataValue(for: DeliveryStatusType.status))
        }
        set(value) {
            self.setDataValue(for: DeliveryStatusType.status, to: StringValue.of(optional: value))
        }
    }

    open var statusType: String? {
        get {
            return StringValue.optional(self.dataValue(for: DeliveryStatusType.statusType))
        }
        set(value) {
            self.setDataValue(for: DeliveryStatusType.statusType, to: StringValue.of(optional: value))
        }
    }
}
