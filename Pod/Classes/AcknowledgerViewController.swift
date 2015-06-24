// =======================================================
// Acknowledger
// Nathaniel Kirby
// https://github.com/nkirby/Acknowledger.git
// =======================================================

import UIKit

// =======================================================

/**
The License delegate provides a few handy customization points for the
license view controller shown when a user taps on an item in the library
list
*/

public protocol AcknowledgerViewControllerLicenseDelegate: NSObjectProtocol {
/**
Returns whether or not to display a license for a given Library
*/

    func shouldShowLicenseForLibrary(library: Library) -> Bool
    
/**
Returns an NSAttributedString containing the full display text for the license of
a Library
*/
    
    func attributedStringForLibrary(library: Library) -> NSAttributedString?
    
/**
Returns the background color to display behind the library's license
*/
    
    func backgroundColorForLibrary(library: Library) -> UIColor?
    
/**
Returns the title to be shown in the navigation controller for a given library
*/
    
    func navigationItemTitleForLibrary(library: Library) -> String?
}

// =======================================================

public class AcknowledgerViewController: UITableViewController {
/**
A read-only copy of the Acknowledger object used within the view controller
*/
    
    private(set) public var acknowledger: Acknowledger?
    
/**
A read-only copy of the array of Library used within the view controller
*/
    
    private(set) var libraries = [Library]()
    
/**
The delegate used to generate information about each library's license view controller
*/
    
    public weak var licenseDelegate: AcknowledgerViewControllerLicenseDelegate?
    
/**
The navigationItem title to display when showing the list of libraries
*/
    
    public var navigationItemTitle = "Acknowledgements"
    
/**
The section header text to show above the list of libraries. This is used in tableView:titleForHeaderInSection:
    
Set to nil for no title.
    
Default is "This application uses the following third party libraries:"
*/
    
    public var sectionHeaderText: String? = "This application uses the following third party libraries:"
    
/**
The section header view to show above the list of libraries. This is used in tableView:viewForHeaderInSection:
*/
    
    public var sectionHeaderView: UIView?
    
/**
Whether or not to override the back button title when showing the license view for a given library. Default is 
false
*/
    
    public var suppressesBackButtonText = false
    
/**
The background color behind the table view. Leave as nil to use the default table view styling
*/

    public var tableViewBackgroundColor: UIColor?
    
/**
The color to use on the separator between UITableViewCells. Leave as nil to use the default table view styling
*/
    
    public var tableViewSeparatorColor: UIColor?
    
/**
The separator style to use between UITableViewCells. Leave as nil to use the default table view styling
*/
    
    public var tableViewSeparatorStyle: UITableViewCellSeparatorStyle?
    
/**
The separator insets to use between UITableViewCells
*/
    
    public var tableViewSeparatorInset: UIEdgeInsets?
    
/**
The inset to use on the section header view
*/
    
    public var tableViewHeaderInset: UIEdgeInsets?
    
/**
The background color for each cell on the library list. Leave as nil to use the default styling
*/
    
    public var tableViewCellBackgroundColor: UIColor?
    
/**
The cell selection style for each cell in the library list.
*/
    
    public var tableViewCellSelectionStyle: UITableViewCellSelectionStyle?
    
/**
The title text font for each cell in the library list.
*/
    
    public var tableViewCellTitleFont: UIFont?
    
/**
The title text color for each cell in the library list.
*/
    
    public var tableViewCellTitleColor: UIColor?
    
/**
The accessoryType for each cell in the library list. Default is UITableViewCellAccessoryType.DisclosureIndicator
*/
    
    public var tableViewCellAccessoryType = UITableViewCellAccessoryType.DisclosureIndicator
    
/**
The accessoryView for each cell in the library list. Default is nil
*/
    
    public var tableViewCellAccessoryView: UIView?
    
// =======================================================
// MARK: - Init, etc...
    
    public override init(style: UITableViewStyle) {
        super.init(style: style)
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
/**
Creates an AcknowledgerViewController given an already parsed Acknowledger object. Handy if you're keeping your
own copy of the Acknowledger object for a given project.
*/
    
    public convenience init(acknowledger: Acknowledger) {
        self.init(style: UITableViewStyle.Grouped)
        
        self.acknowledger = acknowledger
    }

/**
Creates an AcknowledgerViewController by first attempting to create an Acknowledger object from a plistFilename. Throws the same errors as the Acknowledger initializer
*/
    
    public convenience init(plistFilename: String) throws {
        self.init(style: UITableViewStyle.Grouped)
        
        self.acknowledger = try Acknowledger(plistFilename: plistFilename)
    }

/**
Creates an AcknowledgerViewController by first attempting to create an Acknowledger object from a plist. Throws the same errors as the Acknowledger initializer
*/

    public convenience init(plist: [String: AnyObject]) throws {
        self.init(style: UITableViewStyle.Grouped)
        
        self.acknowledger = try Acknowledger(plist: plist)
    }

// =======================================================
// MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = self.navigationItemTitle
        
        if let color = self.tableViewBackgroundColor {
            self.tableView.backgroundColor = color
        }
        
        if let color = self.tableViewSeparatorColor {
            self.tableView.separatorColor = color
        }
        
        if let style = self.tableViewSeparatorStyle {
            self.tableView.separatorStyle = style
        }
        
        if let inset = self.tableViewHeaderInset {
            self.tableView.separatorInset = inset
        }
        
        guard let acknowledger = self.acknowledger else {
            return
        }
        
        self.libraries = acknowledger.allLibraries()
    }

    public override func viewWillAppear(animated: Bool) {
        if self.suppressesBackButtonText {
            self.navigationItem.title = self.navigationItemTitle
        }
        
        super.viewWillAppear(animated)
    }
    
    public override func viewWillDisappear(animated: Bool) {
        if self.suppressesBackButtonText {
            self.navigationItem.title = ""
        }
        
        super.viewWillDisappear(animated)
    }
    
// =======================================================
// MARK: - Table View
    
    public override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    public override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.libraries.count
    }
    
    public override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionHeaderText
    }
    
    public override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.sectionHeaderView
    }
    
    public override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "tableCell")
        
        if indexPath.row > self.libraries.count {
            return cell
        }
        
        let library = self.libraries[indexPath.row]
        cell.textLabel?.text = library.name
        cell.accessoryType = self.tableViewCellAccessoryType
                
        if let selectionStyle = self.tableViewCellSelectionStyle {
            cell.selectionStyle = selectionStyle
        }
        
        if let font = self.tableViewCellTitleFont {
            cell.textLabel?.font = font
        }
        
        if let color = self.tableViewCellTitleColor {
            cell.textLabel?.textColor = color
        }
        
        if let view = self.tableViewCellAccessoryView {
            cell.accessoryView = view
        }
        
        if let color = self.tableViewCellBackgroundColor {
            cell.backgroundColor = color
            cell.contentView.backgroundColor = color
        }
        
        if let inset = self.tableViewSeparatorInset {
            cell.separatorInset = inset
        }
        
        return cell
    }
    
    public override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.row > self.libraries.count {
            return
        }
        
        let library = self.libraries[indexPath.row]
        let show = self.licenseDelegate?.shouldShowLicenseForLibrary(library) ?? true
        if !show {
            return
        }
        
        let attrString: NSAttributedString
        if let string = self.licenseDelegate?.attributedStringForLibrary(library) {
            attrString = string
        } else {
            attrString = NSAttributedString(string: library.license)
        }
        
        let title = self.licenseDelegate?.navigationItemTitleForLibrary(library) ?? library.name
        let vc = AcknowledgerLicenseViewController(attributedString: attrString, title: title)
        vc.view.backgroundColor = self.licenseDelegate?.backgroundColorForLibrary(library) ?? UIColor.whiteColor()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
