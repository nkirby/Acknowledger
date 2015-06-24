// =======================================================
// Acknowledger
// Nathaniel Kirby
// https://github.com/nkirby/Acknowledger.git
// =======================================================

import UIKit

// =======================================================

public class AcknowledgerLicenseViewController: UIViewController {
    private let textView = UITextView(frame: CGRect.zeroRect)

    public init(attributedString: NSAttributedString, title: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.navigationItem.title = title
        
        dispatch_async(dispatch_get_main_queue(), {
            self.textView.attributedText = attributedString
        })
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.textView)
        self.textView.editable = false
        self.textView.backgroundColor = UIColor.clearColor()
    }

    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.textView.frame = self.view.bounds
    }
}
