//
// AppDelegate.swift
// sampleapp
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 15/07/17
//

import SAPFiori
import SAPFoundation
import SAPCommon

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?

    private let logger = Logger.shared(named: "AppDelegateLogger")
    var deliveryService: DeliveryServiceDataAccess!
    var urlSession: SAPURLSession! {
        didSet {
            self.deliveryService = DeliveryServiceDataAccess(urlSession: urlSession)
            self.uploadLogs()
        }
    }

    func applicationDidFinishLaunching(_ application: UIApplication) {

        // set the default log level. Note: LogLevel.all may be too much for your use case! Maybe prefer LogLevel.error.
        Logger.root.logLevel = LogLevel.debug

        do {
            // Attaches a LogUploadFileHandler instance to the root of the logging system.d
            try SAPcpmsLogUploader.attachToRootLogger()
        } catch {
            self.logger.error("Failed to attach to root logger.", error: error)
        }

        let urlSession = SAPURLSession(configuration: URLSessionConfiguration.default)
        urlSession.register(SAPcpmsObserver(applicationID: Constants.appId, deviceID: UIDevice.current.identifierForVendor!.uuidString))
        self.urlSession = urlSession

        UINavigationBar.applyFioriStyle()

        // Override point for customization after application launch.
        let splitViewController = self.window!.rootViewController as! UISplitViewController
        let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count - 1] as! UINavigationController
        navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        splitViewController.delegate = self
        splitViewController.modalPresentationStyle = .currentContext
        splitViewController.preferredDisplayMode = .allVisible
    }

    // MARK: - Split view

    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsMasterController = secondaryAsNavController.topViewController as? MasterViewController else { return false }
        // Without this, on iPhone the main screen is the detailview and the masterview can not be reached.
        if (topAsMasterController.collectionType == .none) {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }

        return false
    }

    // MARK: - Remote Notification handling
    private var deviceToken: Data?
    private var remoteNotificationClient: SAPcpmsRemoteNotificationClient!

    // MARK: - Log uploading

    // This function is invoked on every application start, but you can reuse it to manually triger the logupload.
    private func uploadLogs() {
        SAPcpmsLogUploader.uploadLogs(sapURLSession: self.urlSession, settingsParameters: Constants.configurationParameters) { error in
            if let error = error {
                self.logger.error("Error happened during log upload.", error: error)
                return
            }
            self.logger.info("Logs have been uploaded successfully.")
        }
    }
}
