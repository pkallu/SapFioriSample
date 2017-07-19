//
// PackagesMasterTableDelegate.swift
// sampleapp
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 15/07/17
//
import Foundation
import SAPFoundation
import SAPOData
import SAPCommon

class PackagesMasterTableDelegate: NSObject, MasterTableDelegate {
    private let dataAccess: DeliveryServiceDataAccess
    weak var notifier: Notifier?
    private let logger = Logger.shared(named: "MasterTableDelegateLogger")

    private var _entities: [PackagesType] = [PackagesType]()
    var entities: [EntityValue] {
        get {
            return _entities
        }
        set {
            self._entities = newValue as! [PackagesType]
        }
    }

    init(dataAccess: DeliveryServiceDataAccess) {
        self.dataAccess = dataAccess
    }

    func requestEntities(completionHandler: @escaping(Error?) -> ()) {
        self.dataAccess.loadPackages() { (packages, error) in
            guard let packages = packages else {
                completionHandler(error!)
                return
            }
            self.entities = packages
            completionHandler(nil)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self._entities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let packagestype = self.entities[indexPath.row] as! PackagesType
        let cell = cellWithNonEditableContent(tableView: tableView, indexPath: indexPath, key: "PackageID", value: "\(packagestype.packageID)")
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle != .delete {
            return
        }
        let currentEntity = self._entities[indexPath.row]
        self.dataAccess.service.deleteEntity(currentEntity) { error in
            if let error = error {
                self.logger.error("Delete entry failed.", error: error)
                self.notifier?.displayAlert(title: NSLocalizedString("keyErrorDeletingEntryTitle",
                    value: "Delete entry failed",
                    comment: "XTIT: Title of deleting entry error pop up."),
                message: error.localizedDescription)
                return
            }
            self._entities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
