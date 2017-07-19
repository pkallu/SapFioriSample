//
// PackagesTypeDetailTableDelegate.swift
// sampleapp
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 15/07/17
//
import Foundation
import UIKit
import SAPOData
import SAPCommon

class PackagesTypeDetailTableDelegate: NSObject, DetailTableDelegate {
    private let dataAccess: DeliveryServiceDataAccess
    private var _entity: PackagesType?
    var entity: EntityValue {
        get {
            if _entity == nil {
                _entity = createEntityWithDefaultValues()
            }
            return _entity!
        }
        set {
            _entity = newValue as? PackagesType
        }
    }
    var rightBarButton: UIBarButtonItem
    private var validity = Array(repeating: true, count: 4)

    init(dataAccess: DeliveryServiceDataAccess, rightBarButton: UIBarButtonItem) {
        self.dataAccess = dataAccess
        self.rightBarButton = rightBarButton
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let currentEntity = self.entity as? PackagesType else {
            return cellForDefault(tableView: tableView, indexPath: indexPath)
        }
        switch indexPath.row {
        case 0:
            var value = ""
            if currentEntity.hasDataValue(for: PackagesType.packageID) {
                value = "\(currentEntity.packageID)"
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: PackagesType.packageID, value: value, changeHandler: { (newValue: String) -> Bool in
                if let validValue = TypeValidator.validString(from: newValue, for: PackagesType.packageID) {
                    currentEntity.packageID = validValue
                    self.validity[0] = true
                } else {
                    self.validity[0] = false
                }
                self.barButtonShouldBeEnabled()
                return self.validity[0]
            })
        case 1:
            var value = ""
            if currentEntity.hasDataValue(for: PackagesType.name) {
                if let name = currentEntity.name {
                    value = "\(name)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: PackagesType.name, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.name = nil
                    self.validity[1] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: PackagesType.name) {
                        currentEntity.name = validValue
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
            if currentEntity.hasDataValue(for: PackagesType.description) {
                if let description = currentEntity.description {
                    value = "\(description)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: PackagesType.description, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.description = nil
                    self.validity[2] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: PackagesType.description) {
                        currentEntity.description = validValue
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
            if currentEntity.hasDataValue(for: PackagesType.price) {
                if let price = currentEntity.price {
                    value = "\(price)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: PackagesType.price, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.price = nil
                    self.validity[3] = true
                } else {
                    if let validValue = TypeValidator.validBigDecimal(from: newValue) {
                        currentEntity.price = validValue
                        self.validity[3] = true
                    } else {
                        self.validity[3] = false
                    }
                }
                self.barButtonShouldBeEnabled()
                return self.validity[3]
            })
        case 4:
            let navigationLink = tableView.dequeueReusableCell(withIdentifier: "NavigationLink",
                                                               for: indexPath) as UITableViewCell
            navigationLink.textLabel?.text = "Show Tracking Info..."
            return navigationLink

        default:
            return cellForDefault(tableView: tableView, indexPath: indexPath)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func createEntityWithDefaultValues() -> PackagesType {
        let newEntity = PackagesType()
        newEntity.packageID = defaultValueFor(PackagesType.packageID)
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
