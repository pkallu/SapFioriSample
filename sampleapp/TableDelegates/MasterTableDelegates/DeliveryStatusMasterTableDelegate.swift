//
// DeliveryStatusMasterTableDelegate.swift
// sampleapp
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 15/07/17
//
import Foundation
import SAPFoundation
import SAPOData
import SAPCommon

class DeliveryStatusMasterTableDelegate: NSObject, MasterTableDelegate {
    private let dataAccess: DeliveryServiceDataAccess
    weak var notifier: Notifier?
    private let logger = Logger.shared(named: "MasterTableDelegateLogger")

    private var _entities: [DeliveryStatusType] = [DeliveryStatusType]()
    var entities: [EntityValue] {
        get {
            return _entities
        }
        set {
            self._entities = newValue as! [DeliveryStatusType]
        }
    }

    init(dataAccess: DeliveryServiceDataAccess) {
        self.dataAccess = dataAccess
    }

    func requestEntities(completionHandler: @escaping(Error?) -> ()) {
        self.dataAccess.loadDeliveryStatus() { (deliverystatus, error) in
            guard let deliverystatus = deliverystatus else {
                completionHandler(error!)
                return
            }
            self.entities = deliverystatus
            completionHandler(nil)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self._entities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let deliverystatustype = self.entities[indexPath.row] as! DeliveryStatusType
        let cell = cellWithNonEditableContent(tableView: tableView, indexPath: indexPath, key: "DeliveryStatusID", value: "\(deliverystatustype.deliveryStatusID)")
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
