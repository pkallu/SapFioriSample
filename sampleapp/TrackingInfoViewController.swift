//
//  TrackingInfoViewControllerTableViewController.swift
//  sampleapp
//
//  Created by Pragathi Kallu on 7/15/17.
//  Copyright © 2017 SAP. All rights reserved.
//

import UIKit
import SAPFoundation
import SAPCommon
import SAPOData
import SAPFiori

class TrackingInfoViewController: UITableViewController {
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let logger: Logger = Logger.shared(named: "TrackingInfoViewController")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FUITimelineCell.self, forCellReuseIdentifier: "FUITimelineCell")
        tableView.register(FUITimelineMarkerCell.self, forCellReuseIdentifier: "FUITimelineMarkerCell")
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundColor = UIColor.preferredFioriColor(forStyle: .backgroundBase)
        tableView.separatorStyle = .none
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private var _entities: [DeliveryStatusType] = [DeliveryStatusType]( )
    var entities: [EntityValue] {
        get { return _entities }
        set { self._entities = newValue as! [DeliveryStatusType]
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self._entities.count
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let deliverystatustype = self._entities[indexPath.row]
        
        if deliverystatustype.selectable != 0 {
            return self.getFUITimelineCell(deliverystatustype: deliverystatustype,
                                           indexPath: indexPath)
        }
        else {
            return self.getFUITimelineMarkerCell(deliverystatustype: deliverystatustype,
                                                 indexPath: indexPath)
        }
    }
    
    private func getFUITimelineMarkerCell(deliverystatustype: DeliveryStatusType,
                                          indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FUITimelineMarkerCell", for: indexPath)
        guard let timelineCell = cell as? FUITimelineMarkerCell else {
            return cell
        }
        timelineCell.nodeImage = self.getNodeImage(statusType: deliverystatustype.statusType!)
        timelineCell.showLeadingTimeline = indexPath.row == 0 ? false : true
        timelineCell.showTrailingTimeline = indexPath.row == self._entities.count - 1 ? false : true
        timelineCell.eventText = self.getFormattedDateTime(timestamp: deliverystatustype.deliveryTimestamp!)
        timelineCell.titleText = deliverystatustype.status
        
        return timelineCell
    }
    
    private func getFUITimelineCell(deliverystatustype: DeliveryStatusType,
                                    indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FUITimelineCell", for: indexPath)
        guard let timelineCell = cell as? FUITimelineCell else {
            return cell
        }
        timelineCell.nodeImage = self.getNodeImage(statusType: deliverystatustype.statusType!)
        timelineCell.eventText = self.getFormattedDateTime(timestamp: deliverystatustype.deliveryTimestamp!)
        timelineCell.headlineText = deliverystatustype.status
        timelineCell.subheadlineText = deliverystatustype.location
        
        return timelineCell
    }
    
    private func getFormattedDateTime(timestamp: LocalDateTime) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd HH:mm"
        
        return formatter.string(from: timestamp.utc())
    }
    
    private func getNodeImage(statusType: String) -> UIImage {
        switch statusType {
        case "start"    : return FUITimelineNode.start
        case "inactive" : return FUITimelineNode.inactive
        case "complete" : return FUITimelineNode.complete
        case "earlyEnd" : return FUITimelineNode.earlyEnd
        case "end"      : return FUITimelineNode.end
        default         : return FUITimelineNode.open
        }
    }

}
