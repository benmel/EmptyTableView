//
//  EmptyBackgroundView.swift
//  EmptyTableView
//
//  Created by Ben Meline on 12/1/15.
//  Copyright © 2015 Ben Meline. All rights reserved.
//

import UIKit
import PureLayout

class EmptyBackgroundView: UIView {
    
    private var topSpace: UIView!
    private var bottomSpace: UIView!
    private var imageView: UIImageView!
    private var topLabel: UILabel!
    private var bottomLabel: UILabel!
    
    private let topColor = UIColor.darkGrayColor()
    private let topFont = UIFont.boldSystemFontOfSize(22)
    private let bottomColor = UIColor.grayColor()
    private let bottomFont = UIFont.systemFontOfSize(18)
    
    private let spacing: CGFloat = 10
    private let imageViewHeight: CGFloat = 100
    private let bottomLabelWidth: CGFloat = 300
    
    var didSetupConstraints = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    init(image: UIImage, top: String, bottom: String) {
        super.init(frame: CGRectZero)
        setupViews()
        setupImageView(image)
        setupLabels(top, bottom: bottom)
    }
    
    func setupViews() {
        topSpace = UIView.newAutoLayoutView()
        bottomSpace = UIView.newAutoLayoutView()
        imageView = UIImageView.newAutoLayoutView()
        topLabel = UILabel.newAutoLayoutView()
        bottomLabel = UILabel.newAutoLayoutView()
        
        addSubview(topSpace)
        addSubview(bottomSpace)
        addSubview(imageView)
        addSubview(topLabel)
        addSubview(bottomLabel)
    }
    
    func setupImageView(image: UIImage) {
        imageView.image = image
        imageView.tintColor = topColor
    }
    
    func setupLabels(top: String, bottom: String) {
        topLabel.text = top
        topLabel.textColor = topColor
        topLabel.font = topFont
        
        bottomLabel.text = bottom
        bottomLabel.textColor = bottomColor
        bottomLabel.font = bottomFont
        bottomLabel.numberOfLines = 0
        bottomLabel.textAlignment = .Center
    }
    
    override func updateConstraints() {
        if !didSetupConstraints {
            topSpace.autoAlignAxisToSuperviewAxis(.Vertical)
            topSpace.autoPinEdgeToSuperviewEdge(.Top)
            bottomSpace.autoAlignAxisToSuperviewAxis(.Vertical)
            bottomSpace.autoPinEdgeToSuperviewEdge(.Bottom)
            topSpace.autoSetDimension(.Height, toSize: spacing, relation: .GreaterThanOrEqual)
            topSpace.autoMatchDimension(.Height, toDimension: .Height, ofView: bottomSpace)
            
            imageView.autoPinEdge(.Top, toEdge: .Bottom, ofView: topSpace)
            imageView.autoAlignAxisToSuperviewAxis(.Vertical)
            imageView.autoSetDimension(.Height, toSize: imageViewHeight, relation: .LessThanOrEqual)
            
            topLabel.autoAlignAxisToSuperviewAxis(.Vertical)
            topLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: imageView, withOffset: spacing)
            
            bottomLabel.autoAlignAxisToSuperviewAxis(.Vertical)
            bottomLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: topLabel, withOffset: spacing)
            bottomLabel.autoPinEdge(.Bottom, toEdge: .Top, ofView: bottomSpace)
            bottomLabel.autoSetDimension(.Width, toSize: bottomLabelWidth)
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
}
