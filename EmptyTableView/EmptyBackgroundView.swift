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
    
    private let topColor = UIColor.darkGray
    private let topFont = UIFont.boldSystemFont(ofSize:22)
    private let bottomColor = UIColor.gray
    private let bottomFont = UIFont.systemFont(ofSize:18)
    
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
        super.init(frame: CGRect())
        setupViews()
        setupImageView(image: image)
        setupLabels(top: top, bottom: bottom)
    }
    
    func setupViews() {
        topSpace = UIView.newAutoLayout()
        bottomSpace = UIView.newAutoLayout()
        imageView = UIImageView.newAutoLayout()
        topLabel = UILabel.newAutoLayout()
        bottomLabel = UILabel.newAutoLayout()
        
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
        bottomLabel.textAlignment = .center
    }
    
    override func updateConstraints() {
        if !didSetupConstraints {
            topSpace.autoAlignAxis(toSuperviewAxis: .vertical)
            topSpace.autoPinEdge(toSuperviewEdge: .top)
            bottomSpace.autoAlignAxis(toSuperviewAxis: .vertical)
            bottomSpace.autoPinEdge(toSuperviewEdge: .bottom)
            topSpace.autoSetDimension(.height, toSize: spacing, relation: .greaterThanOrEqual)
            topSpace.autoMatch(.height, to: .height, of: bottomSpace)
            
            imageView.autoPinEdge(.top, to: .bottom, of: topSpace)
            imageView.autoAlignAxis(toSuperviewAxis: .vertical)
            imageView.autoSetDimension(.height, toSize: imageViewHeight, relation: .lessThanOrEqual)
            
            topLabel.autoAlignAxis(toSuperviewAxis: .vertical)
            topLabel.autoPinEdge(.top, to: .bottom, of: imageView, withOffset: spacing)
            
            bottomLabel.autoAlignAxis(toSuperviewAxis: .vertical)
            bottomLabel.autoPinEdge(.top, to: .bottom, of: topLabel, withOffset: spacing)
            bottomLabel.autoPinEdge(.bottom, to: .top, of: bottomSpace)
            bottomLabel.autoSetDimension(.width, toSize: bottomLabelWidth)
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
}
