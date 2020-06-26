import UIKit

@IBDesignable
class RoundedView: UIView {
    
    private var _showShadow:Bool = false
    private var _isCircle:Bool = false
    private var _isTopCornerRadius : Bool = false
    private var _isBottomCornerRadius : Bool = false
    private var _dashBorderColor: UIColor = #colorLiteral(red: 0.7725490196, green: 0.7725490196, blue: 0.7725490196, alpha: 1)
    private var _dashBorderWidth: CGFloat = 1.0
    private var _dashBorderCornerRadius: CGFloat = 15.0
    private var _shadowColor: UIColor = #colorLiteral(red: 0.7725490196, green: 0.7725490196, blue: 0.7725490196, alpha: 1)
    private var _shadowOpacity: Float = 0
    private var _shadowOffset: CGSize = CGSize(width: 0.0, height: 0.0)
    private var _shadowRadius: CGFloat = 0.0
    private var shadowLayer: CAShapeLayer!
    private var _gradientRadius:CGFloat = 0.0
    
    @IBInspectable var isTopCornerRadius : Bool = false {
        didSet{
            self._isTopCornerRadius = isTopCornerRadius
        }
    }
    @IBInspectable var isBottomCornerRadius : Bool = false {
        didSet{
            self._isBottomCornerRadius = isBottomCornerRadius
        }
    }
    
    @IBInspectable var isCircle:Bool = false {
        didSet {
            self._isCircle = isCircle
        }
    }
    
    @IBInspectable var showShadow:Bool = false {
        didSet {
            self._showShadow = showShadow
        }
    }
    
    @IBInspectable var cornerRadius : CGFloat = 0 {
        didSet{
            self.layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderColor : UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) {
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth : CGFloat = 0 {
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var shadowColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) {
        didSet{
            self._shadowColor = shadowColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.0 {
        didSet{
            self._shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0.0, height: 0.0) {
        didSet{
            self._shadowOffset = shadowOffset
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0.0 {
        didSet{
            self._shadowRadius = shadowRadius
        }
    }
    @IBInspectable var gradientLayerRadius: CGFloat = 0.0 {
        didSet{
            self._gradientRadius = gradientLayerRadius
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupBorder()
        setupCircleBtn()
        addShadow()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupBorder()
        setupCircleBtn()
        addShadow()
    }
    
    private func setupBorder(){
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = cornerRadius
        if _isTopCornerRadius {
            self.layer.masksToBounds = true
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        if _isBottomCornerRadius {
            self.layer.masksToBounds = true
            self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        }
    }
    
    private func setupCircleBtn(){
        if _isCircle {
            self.layer.cornerRadius = self.frame.height / 2
            self.clipsToBounds = true
        }else {
            setupBorder()
        }
    }
    
    private func addShadow() {
        if _showShadow {
            layer.shadowColor = shadowColor.cgColor
            layer.shadowOpacity = shadowOpacity
            layer.shadowOffset = shadowOffset
            layer.shadowRadius = shadowRadius
            layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            layer.masksToBounds = true
            clipsToBounds = false
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        SetupView()
        SetupView2()
    }
    
    
    
    @IBInspectable var leftColor : UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0) {
        didSet
        {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var rightColor : UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0) {
        didSet
        {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var topColor : UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)  {
        didSet
        {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor : UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)  {
        didSet
        {
            self.setNeedsLayout()
        }
    }
    
    
    
    
    private func SetupView(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [leftColor.cgColor,rightColor.cgColor]
        gradientLayer.locations = [0.0,1.0]
        gradientLayer.startPoint = CGPoint(x: 0, y:0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    private func SetupView2(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor,bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        //gradientLayer.cornerRadius = gradientLayerRadius
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
