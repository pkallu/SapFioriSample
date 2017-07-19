//
// CollectionType.swift
// sampleapp
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 15/07/17
//

import Foundation

enum CollectionType: String {

    case packages = "Packages"
    case deliveryStatus = "DeliveryStatus"
    case none = ""

    private static let all = [
        packages, deliveryStatus]

    static let allValues = CollectionType.all.map { (type) -> String in
        return type.rawValue
    }
}
