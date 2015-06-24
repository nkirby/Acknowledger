// =======================================================
// Acknowledger
// Nathaniel Kirby
// https://github.com/nkirby/Acknowledger.git
// =======================================================

import UIKit
import Acknowledger

// =======================================================

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title = "Demo"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

// =======================================================
// MARK: - Presenting
    
    private func presentStandardAcknowledgerUI() {
        let vc = try! AcknowledgerViewController(plistFilename: "Pods-acknowledgements.plist")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func presentCustomAcknowledgerUI() {
        let vc = try! AcknowledgerViewController(plistFilename: "Pods-acknowledgements.plist")
        vc.navigationItemTitle = "Libraries"
        vc.sectionHeaderText = "This app is using the following:"
        vc.suppressesBackButtonText = true
        
        vc.tableViewBackgroundColor = UIColor.whiteColor()
        vc.tableViewSeparatorStyle = UITableViewCellSeparatorStyle.None
        vc.tableViewCellSelectionStyle = UITableViewCellSelectionStyle.None
        vc.tableViewCellTitleFont = UIFont(name: "HelveticaNeue-Light", size: 16.0)
        vc.tableViewCellAccessoryType = .None
        vc.tableViewCellTitleColor = UIColor(white: 0.35, alpha: 1.0)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func presentExtraCustomAcknowledgerUI() {
        let vc = try! AcknowledgerViewController(plistFilename: "Pods-acknowledgements.plist")
        vc.navigationItemTitle = "Libraries"
        vc.sectionHeaderText = "This app is using the following:"
        vc.suppressesBackButtonText = true
        
        let headerView = UIView(frame: CGRect.zeroRect)
        headerView.backgroundColor = UIColor.greenColor()
        vc.sectionHeaderView = headerView
        
        vc.tableViewBackgroundColor = UIColor.blackColor()
        vc.tableViewSeparatorStyle = UITableViewCellSeparatorStyle.SingleLine
        vc.tableViewSeparatorColor = UIColor.blueColor()
        vc.tableViewCellTitleFont = UIFont(name: "Marker Felt", size: 24.0)
        vc.tableViewCellTitleColor = UIColor.purpleColor()
        vc.tableViewCellAccessoryType = .Checkmark
        vc.tableViewCellBackgroundColor = UIColor.clearColor()

        vc.licenseDelegate = self
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
// =======================================================
// MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "tableCell")
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Default Styling"
            cell.accessoryType = .DisclosureIndicator
            
        case 1:
            cell.textLabel?.text = "Custom Styling 1"
            cell.accessoryType = .DisclosureIndicator

        case 2:
            cell.textLabel?.text = "Custom Styling 2"
            cell.accessoryType = .DisclosureIndicator

        default:
            break
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            self.presentStandardAcknowledgerUI()
            
        case 1:
            self.presentCustomAcknowledgerUI()

        case 2:
            self.presentExtraCustomAcknowledgerUI()

        default:
            break
        }
    }
}

// =======================================================

extension ViewController: AcknowledgerViewControllerLicenseDelegate {
    func shouldShowLicenseForLibrary(library: Library) -> Bool {
        return (library.name != "TMCache")
    }
    
    func attributedStringForLibrary(library: Library) -> NSAttributedString? {
        return NSAttributedString(string: library.license, attributes: [NSFontAttributeName: UIFont(name: "Marker Felt", size: 24.0)!, NSForegroundColorAttributeName: UIColor.purpleColor()])
    }
    
    func backgroundColorForLibrary(library: Library) -> UIColor? {
        return UIColor.blackColor()
    }
    
    func navigationItemTitleForLibrary(library: Library) -> String? {
        return "Wow. Such \(library.name)"
    }
}
