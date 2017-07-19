//
// DeliveryStatusTypeDetailTableDelegate.swift
// sampleapp
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 15/07/17
//
import Foundation
import UIKit
import SAPOData
import SAPCommon

class DeliveryStatusTypeDetailTableDelegate: NSObject, DetailTableDelegate {
    private let dataAccess: DeliveryServiceDataAccess
    private var _entity: DeliveryStatusType?
    var entity: EntityValue {
        get {
            if _entity == nil {
                _entity = createEntityWithDefaultValues()
            }
            return _entity!
        }
        set {
            _entity = newValue as? DeliveryStatusType
        }
    }
    var rightBarButton: UIBarButtonItem
    private var validity = Array(repeating: true, count: 7)

    init(dataAccess: DeliveryServiceDataAccess, rightBarButton: UIBarButtonItem) {
        self.dataAccess = dataAccess
        self.rightBarButton = rightBarButton
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let currentEntity = self.entity as? DeliveryStatusType else {
            return cellForDefault(tableView: tableView, indexPath: indexPath)
        }
        switch indexPath.row {
        case 0:
            var value = ""
            if currentEntity.hasDataValue(for: DeliveryStatusType.deliveryStatusID) {
                value = "\(currentEntity.deliveryStatusID)"
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: DeliveryStatusType.deliveryStatusID, value: value, changeHandler: { (newValue: String) -> Bool in
                if let validValue = TypeValidator.validString(from: newValue, for: DeliveryStatusType.deliveryStatusID) {
                    currentEntity.deliveryStatusID = validValue
                    self.validity[0] = true
                } else {
                    self.validity[0] = false
                }
                self.barButtonShouldBeEnabled()
                return self.validity[0]
            })
        case 1:
            var value = ""
            if currentEntity.hasDataValue(for: DeliveryStatusType.packageID) {
                if let packageID = currentEntity.packageID {
                    value = "\(packageID)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: DeliveryStatusType.packageID, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.packageID = nil
                    self.validity[1] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: DeliveryStatusType.packageID) {
                        currentEntity.packageID = validValue
                        self.validity[1] = true
                    } else {
                        self.validity[1] = false
                    }
                }
                self.barButtonShouldBeEnabled()
                return self.validity[1]
            })
        case 2:
            var value = ""
            if currentEntity.hasDataValue(for: DeliveryStatusType.location) {
                if let location = currentEntity.location {
                    value = "\(location)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: DeliveryStatusType.location, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.location = nil
                    self.validity[2] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: DeliveryStatusType.location) {
                        currentEntity.location = validValue
                        self.validity[2] = true
                    } else {
                        self.validity[2] = false
                    }
                }
                self.barButtonShouldBeEnabled()
                return self.validity[2]
            })
        case 3:
            var value = ""
            if currentEntity.hasDataValue(for: DeliveryStatusType.deliveryTimestamp) {
                if let deliveryTimestamp = currentEntity.deliveryTimestamp {
                    value = "\(deliveryTimestamp)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: DeliveryStatusType.deliveryTimestamp, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.deliveryTimestamp = nil
                    self.validity[3] = true
                } else {
                    if let validValue = TypeValidator.validLocalDateTime(from: newValue) { // This is just a simple solution to handle UTC only
                        currentEntity.deliveryTimestamp = validValue
                        self.validity[3] = true
                    } else {
                        self.validity[3] = false
                    }
                }
                self.barButtonShouldBeEnabled()
                return self.validity[3]
            })
        case 4:
            var value = ""
            if currentEntity.hasDataValue(for: DeliveryStatusType.statusType) {
                if let statusType = currentEntity.statusType {
                    value = "\(statusType)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: DeliveryStatusType.statusType, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.statusType = nil
                    self.validity[4] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: DeliveryStatusType.statusType) {
                        currentEntity.statusType = validValue
                        self.validity[4] = true
                    } else {
                        self.validity[4] = false
                    }
                }
                self.barButtonShouldBeEnabled()
                return self.validity[4]
            })
        case 5:
            var value = ""
            if currentEntity.hasDataValue(for: DeliveryStatusType.selectable) {
                if let selectable = currentEntity.selectable {
                    value = "\(selectable)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: DeliveryStatusType.selectable, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.selectable = nil
                    self.validity[5] = true
                } else {
                    if let validValue = TypeValidator.validInteger(from: newValue) {
                        currentEntity.selectable = validValue
                        self.validity[5] = true
                    } else {
                        self.validity[5] = false
                    }
                }
                self.barButtonShouldBeEnabled()
                return self.validity[5]
            })
        case 6:
            var value = ""
            if currentEntity.hasDataValue(for: DeliveryStatusType.status) {
                if let status = currentEntity.status {
                    value = "\(status)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: DeliveryStatusType.status, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.status = nil
                    self.validity[6] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: DeliveryStatusType.status) {
                        currentEntity.status = validValue
                        self.validity[6] = true
                    } else {
                        self.validity[6] = false
                    }
                }
                self.barButtonShouldBeEnabled()
                return self.validity[6]
            })
        default:
            return cellForDefault(tableView: tableView, indexPath: indexPath)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func createEntityWithDefaultValues() -> DeliveryStatusType {
        let newEntity = DeliveryStatusType()
        newEntity.deliveryStatusID = defaultValueFor(DeliveryStatusType.deliveryStatusID)
        return newEntity
    }

    // Check if all text fields are valid
    private func barButtonShouldBeEnabled() {
        let anyFieldInvalid = self.validity.first { (field) -> Bool in
            return field == false
        }
        self.rightBarButton.isEnabled = anyFieldInvalid == nil
    }
}
