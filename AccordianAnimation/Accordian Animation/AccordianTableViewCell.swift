//
//  AccordianTableViewCell.swift
//  AccordianAnimation
//
//  Created by Varun on 23/06/16.
//  Copyright © 2016 YMediaLabs. All rights reserved.
//

import UIKit

class AccordianTableViewCell: UITableViewCell {
    /** **Important: The Height constraint has to be set for infoView instead of bottom constraint** 
    
    Info view should be the container view holding all the views as subviews that represent the cell in unexpanded state */
    @IBOutlet weak var infoView: UIView!
    
    /// This variable holds the arrow view if present which needs rotation animation
    @IBOutlet weak var arrowView: UIView!
    
    /// Details view is the container view holding all the views as subviews that represent the cell in expanded state (View controller data)
    var detailsView: UIView!
    
    /// Set this variable if animation of arrow image is needed. Set the direction for initial and final direction so that rotation is done clockwise direction from current to final direction. Defaults to `Right` to `Down` Clockwise
    var arrowImageCurrentDirection : ArrowDirection = .Right
    var arrowImageFinalDirection : ArrowDirection = .Down
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Check if infoView is set or not. If not do not proceed further
        assert(infoView != nil, "InfoView cannot be nil")
        
        // Check if height constraint is set or not
        let constraintCheck = { [weak self] (constraint : NSLayoutConstraint) -> Bool in
            if self == nil {
                return false
            }
            
            if constraint.firstAttribute == .Height && constraint.firstItem as? NSObject == self?.infoView {
                return true
            }
            else {
                return false
            }
        }
        
        var isHeightConstraintAdded = false
        for constraint in infoView.constraints {
            isHeightConstraintAdded = constraintCheck(constraint)
            
            if isHeightConstraintAdded {
                break
            }
        }
        
        assert(isHeightConstraintAdded, "InfoView has to have a height constraint")
        
        // Create details view
        if detailsView == nil {
            detailsView = UIView(frame: CGRectZero)
            addSubview(detailsView)
            
            // Add necessary constraints
            detailsView.translatesAutoresizingMaskIntoConstraints = false
            
            let horizontalConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[view]-0-|", options: [], metrics: nil, views: ["view" : detailsView])
            let bottomConstraint = NSLayoutConstraint(item: detailsView, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
            let topConstraint = NSLayoutConstraint(item: detailsView, attribute: .Top, relatedBy: .Equal, toItem: infoView, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
            
            addConstraints(horizontalConstraint)
            addConstraints([bottomConstraint, topConstraint])
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.arrowView?.hidden = false
        
        // Remove subviews from details view when reusing cells
        for subview in detailsView.subviews {
            subview.removeFromSuperview()
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
