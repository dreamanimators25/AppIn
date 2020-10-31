//(
//  GradientView.swift
//  iList
//
//  Created by Pontus Andersson on 2014-09-29.
//  Copyright (c) 2014 iList. All rights reserved.
//

import UIKit


class oldGradientView: UIView {
    
    fileprivate var gradientLayer: CAGradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.gradientLayer.frame = self.bounds
    }
    
    fileprivate func setup(){
        self.backgroundColor = UIColor.clear
        
//        let arrayWithColors: Array<AnyObject> = [ UIColor.clearColor().CGColor, ThemeHandler.sharedInstance.getTintColor().CGColor, ThemeHandler.sharedInstance.getTintColor().CGColor, UIColor.clearColor().CGColor]
//        let locations: Array<Float> = [0.0, 0.2, 0.8, 1.0]
//        self.setGradientColors(arrayWithColors, locations: locations)
    }
    
    func setDefaultGradientColors() {
//        let arrayWithColors: Array<AnyObject> = [ UIColor.clearColor().CGColor, ThemeHandler.sharedInstance.getTintColor().CGColor, ThemeHandler.sharedInstance.getTintColor().CGColor, UIColor.clearColor().CGColor]
//        let locations: Array<Float> = [0.0, 0.2, 0.8, 1.0]
//        self.setGradientColors(arrayWithColors, locations: locations)
    }

    func setAmbassadorListGradientColors() {
//        let arrayWithColors: Array<AnyObject> = [ ThemeHandler.sharedInstance.getTintColor().CGColor, UIColor.clearColor().CGColor ]
//        let locations: Array<Float> = [0.0, 0.9]
//        self.setGradientColors(arrayWithColors, locations: locations)
    }
    
    func setHorizontalGradientColors(_ arrayWithColors: Array<AnyObject>, locations: Array<Float>) {
        gradientLayer.frame = self.bounds
        
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5);
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5);
        
        gradientLayer.colors = arrayWithColors
        gradientLayer.locations = locations as [NSNumber]?
        
        self.layer.addSublayer(gradientLayer) //insertSublayer(gradientLayer, atIndex: 0)
    }
    
    func setVerticalGradientColors(_ arrayWithColors: Array<AnyObject>, locations: Array<Float>) {
        gradientLayer.frame = self.bounds
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0);
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0);
        
        gradientLayer.colors = arrayWithColors
        gradientLayer.locations = locations as [NSNumber]?
        
        self.layer.addSublayer(gradientLayer) //insertSublayer(gradientLayer, atIndex: 0)
    }
}

@IBDesignable class GradientView: UIView {
    @IBInspectable var firstColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
    @IBInspectable var secondColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

    @IBInspectable var vertical: Bool = true

    lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [firstColor.cgColor, secondColor.cgColor]
        layer.startPoint = CGPoint.zero
        return layer
    }()

    //MARK: -

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        applyGradient()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        applyGradient()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        applyGradient()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateGradientFrame()
    }

    //MARK: -

    func applyGradient() {
        updateGradientDirection()
        layer.sublayers = [gradientLayer]
    }

    func updateGradientFrame() {
        gradientLayer.frame = bounds
    }

    func updateGradientDirection() {
        gradientLayer.endPoint = vertical ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0)
    }
}

@IBDesignable class ThreeColorsGradientView: UIView {
    @IBInspectable var firstColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    @IBInspectable var secondColor: UIColor = #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1)
    @IBInspectable var thirdColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

    @IBInspectable var vertical: Bool = true {
        didSet {
            updateGradientDirection()
        }
    }

    lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [firstColor.cgColor, secondColor.cgColor, thirdColor.cgColor]
        layer.startPoint = CGPoint.zero
        return layer
    }()

    //MARK: -

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        applyGradient()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        applyGradient()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        applyGradient()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateGradientFrame()
    }

    //MARK: -

    func applyGradient() {
        updateGradientDirection()
        layer.sublayers = [gradientLayer]
    }

    func updateGradientFrame() {
        gradientLayer.frame = bounds
    }

    func updateGradientDirection() {
        gradientLayer.endPoint = vertical ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0)
    }
}

@IBDesignable class RadialGradientView: UIView {

    @IBInspectable var outsideColor: UIColor = UIColor.red
    @IBInspectable var insideColor: UIColor = UIColor.green

    override func awakeFromNib() {
        super.awakeFromNib()

        applyGradient()
    }

    func applyGradient() {
        let colors = [insideColor.cgColor, outsideColor.cgColor] as CFArray
        let endRadius = sqrt(pow(frame.width/2, 2) + pow(frame.height/2, 2))
        let center = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        let gradient = CGGradient(colorsSpace: nil, colors: colors, locations: nil)
        let context = UIGraphicsGetCurrentContext()

        context?.drawRadialGradient(gradient!, startCenter: center, startRadius: 0.0, endCenter: center, endRadius: endRadius, options: CGGradientDrawingOptions.drawsBeforeStartLocation)
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        #if TARGET_INTERFACE_BUILDER
            applyGradient()
        #endif
    }
}
