//
// MasterTableDelegate.swift
// sampleapp
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 15/07/17
//

import Foundation
import SAPOData
import SAPFiori

protocol MasterTableDelegate: UITableViewDelegate, UITableViewDataSource {
    var entities: [EntityValue] { get set }

    func requestEntities(completionHandler: @escaping(Error?) -> Void)

    weak var notifier: Notifier? { get set }
}

extension MasterTableDelegate {

    func cellWithNonEditableContent(tableView: UITableView, indexPath: IndexPath, key: String, value: String) -> FUIObjectTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FUIObjectTableViewCell.reuseIdentifier, for: indexPath as IndexPath) as! FUIObjectTableViewCell
        cell.headlineText = value
        cell.footnoteText = key
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension MasterViewController {

    func generatedTableDelegate() -> MasterTableDelegate? {
        switch collectionType {
        case .packages:
            return PackagesMasterTableDelegate(dataAccess: self.deliveryService)
        case .deliveryStatus:
            return DeliveryStatusMasterTableDelegate(dataAccess: self.deliveryService)
        default:
            return nil
        }
    }
}
