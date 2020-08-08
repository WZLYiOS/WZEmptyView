//
//  EmptyProtocol.swift
//  WZEmptyView
//
//  Created by xiaobin liu on 2020/1/15.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

/// MARK - 空视图(布局顺序从上到下依次为：iconImageView, loadingView, titleLabel, detailTextLabel, actionButton)
public class EmptyView: UIView {
    
    /// 图标视图
    private lazy var iconImageView: UIImageView = {
        let temView = UIImageView()
        temView.contentMode = .center
        return temView
    }()
    
    
    /// 加载视图
    public var loadingView: Indicator =  ActivityIndicator() {
        didSet {
            oldValue.view.removeFromSuperview()
            contentView.addSubview(loadingView.view)
            setNeedsLayout()
        }
    }
    
    /// 标题标签
    private lazy var titleLabel: UILabel = {
        let temLable = UILabel()
        temLable.textAlignment = .center
        temLable.numberOfLines = 0
        temLable.font = titleTextLabelFont
        temLable.textColor = titleLabelTextColor
        return temLable
    }()
    
    /// 详情标签
    private lazy var detailTextLabel: UILabel = {
        
        let temLabel = UILabel()
        temLabel.textAlignment = .center
        temLabel.numberOfLines = 0
        temLabel.font = detailTextLabelFont
        temLabel.textColor = detailTextLabelTextColor
        return temLabel
    }()
    
    /// 事件按钮
    private lazy var actionButton: UIButton = {
        let temButton = UIButton(type: .custom)
        temButton.titleLabel?.font = actionButtonFont
        temButton.setTitleColor(actionButtonTitleNormalColor, for: UIControl.State.normal)
        temButton.setTitleColor(actionButtonTitleHighlightedColor, for: UIControl.State.highlighted)
        return temButton
    }()
    
    
    /**
     *  如果要继承WZEmptyView并添加新的子 view，则必须：
     *  1. 像其它自带 view 一样添加到 contentView 上
     *  2. 重写sizeThatContentViewFits
     */
    private lazy var contentView: UIView = {
        return UIView()
    }()
    
    /// 保证内容超出屏幕时也不至于直接被clip（比如横屏时)
    private lazy var scrollView: UIScrollView = {
        
        let scrollView = UIScrollView()
        if #available(iOS 11, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10) // 避免 label 直接撑满到屏幕两边，不好看
        return scrollView
    }()
    
    // 可通过调整这些insets来控制间距
    /// 默认为(0, 0, 36, 0)
    @objc public dynamic var iconImageViewInsets = UIEdgeInsets(top: 0, left: 0, bottom: 36, right: 0) {
        didSet {
            setNeedsLayout()
        }
    }
    
    /// 默认为(0, 0, 36, 0)
    @objc public dynamic var loadingViewInsets = UIEdgeInsets(top: 0, left: 0, bottom: 36, right: 0) {
        didSet {
            setNeedsLayout()
        }
    }
    
    /// 默认为(0, 0, 10, 0)
    @objc public dynamic var titleTextLabelInsets = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0) {
        didSet {
            setNeedsLayout()
        }
    }
    
    /// 默认为(0, 0, 10, 0)
    @objc public dynamic var detailTextLabelInsets = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0) {
        didSet {
            setNeedsLayout()
        }
    }
    
    /// 默认为(0, 0, 0, 0)
    @objc public dynamic var actionButtonInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) {
        didSet {
            setNeedsLayout()
        }
    }
    
    /// 事件按钮大小
    @objc public dynamic var actionButtonSize = CGSize.zero {
        didSet {
            setNeedsLayout()
        }
    }
    
    /// 如果不想要内容整体垂直居中，则可通过调整此属性来进行垂直偏移。默认为-30，即内容比中间略微偏上
    @objc public dynamic var verticalOffset: CGFloat = -30 {
        didSet {
            setNeedsLayout()
        }
    }
    
    
    // 字体
    /// 默认为15pt系统字体
    @objc public dynamic var titleTextLabelFont = UIFont.systemFont(ofSize: 15) {
        didSet {
            titleLabel.font = titleTextLabelFont
            setNeedsLayout()
        }
    }
    
    /// 默认为14pt系统字体
    @objc public dynamic var detailTextLabelFont = UIFont.systemFont(ofSize: 14) {
        didSet {
            detailTextLabel.font = detailTextLabelFont
            setNeedsLayout()
        }
    }
    
    /// 默认为15pt系统字体
    @objc public dynamic var actionButtonFont = UIFont.systemFont(ofSize: 15) {
        didSet {
            actionButton.titleLabel?.font = actionButtonFont
            setNeedsLayout()
        }
    }
    
    /// 圆角
    @objc public dynamic var actionButtonCornerRadius: CGFloat = 0 {
        didSet {
            actionButton.layer.cornerRadius = actionButtonCornerRadius
            actionButton.layer.masksToBounds = true
            setNeedsLayout()
        }
    }
    
    /// 圆边宽度
    @objc public dynamic var actionButtonBorderWidth: CGFloat = 0 {
        didSet {
            actionButton.layer.borderWidth = actionButtonBorderWidth
            setNeedsLayout()
        }
    }
    
    
    // 颜色
    /// 默认为(93, 100, 110)
    @objc public dynamic var titleLabelTextColor = UIColor(red: 93/255.0, green: 100/255.0, blue: 110/255.0, alpha: 1.0) {
        didSet {
            titleLabel.textColor = titleLabelTextColor
        }
    }
    
    /// 默认为(133, 140, 150)
    @objc public dynamic var detailTextLabelTextColor = UIColor(red: 133/255.0, green: 140/255.0, blue: 150/255.0, alpha: 1.0) {
        didSet {
            detailTextLabel.textColor = detailTextLabelTextColor
        }
    }
    
    /// 默认为UIColor.white
    @objc public dynamic var actionButtonTitleNormalColor = UIColor.white {
        didSet {
            actionButton.setTitleColor(actionButtonTitleNormalColor, for: UIControl.State.normal)
        }
    }
    
    /// 默认为UIColor.white
    @objc public dynamic var actionButtonTitleHighlightedColor = UIColor.white {
        didSet {
            actionButton.setTitleColor(actionButtonTitleHighlightedColor, for: UIControl.State.highlighted)
        }
    }
    
    /// 初始化
    init() {
        super.init(frame: CGRect.zero)
        setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    /// 配置设置
    private func setup() {
        setupView()
        setupLocation()
    }
    
    /// 配置视图
    private func setupView() {
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(loadingView.view)
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailTextLabel)
        contentView.addSubview(actionButton)
    }
    
    /// 配置位置
    private func setupLocation() {
        
        scrollView.frame = bounds
        
        let contentViewSize = sizeThatContentViewFits.flatted
        
        contentView.frame = CGRect(x: 0, y: scrollView.bounds.midY - contentViewSize.height / 2 + verticalOffset, width: contentViewSize.width, height: contentViewSize.height)
        
        scrollView.contentSize = CGSize(width: max(scrollView.bounds.width - scrollView.contentInset.horizontalValue, contentViewSize.width), height: max(scrollView.bounds.height - scrollView.contentInset.verticalValue, contentView.frame.maxY))
        
        var originY: CGFloat = 0
        
        if !iconImageView.isHidden {
            iconImageView.sizeToFit()
            iconImageView.frame = iconImageView.frame.setXY(iconImageView.frame.minXHorizontallyCenter(in: contentView.bounds) + iconImageViewInsets.left - iconImageViewInsets.right, originY + iconImageViewInsets.top)
            originY = iconImageView.frame.maxY + iconImageViewInsets.bottom
        }
        
        if !loadingView.view.isHidden {
            loadingView.view.frame = loadingView.view.frame.setXY(loadingView.view.frame.minXHorizontallyCenter(in: contentView.bounds) + loadingViewInsets.left - loadingViewInsets.right, originY + loadingViewInsets.top)
            originY = loadingView.view.frame.maxY + loadingViewInsets.bottom
        }
        
        if !titleLabel.isHidden {
            let labelWidth = contentView.bounds.width - titleTextLabelInsets.horizontalValue
            let labelSize = titleLabel.sizeThatFits(CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude))
            titleLabel.frame = CGRect(x: titleTextLabelInsets.left, y: originY + titleTextLabelInsets.top, width: labelWidth, height: labelSize.height).flatted
            originY = titleLabel.frame.maxY + titleTextLabelInsets.bottom
        }
        
        if !detailTextLabel.isHidden {
            let labelWidth = contentView.bounds.width - detailTextLabelInsets.horizontalValue
            let labelSize = detailTextLabel.sizeThatFits(CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude))
            detailTextLabel.frame = CGRect(x: detailTextLabelInsets.left, y: originY + detailTextLabelInsets.top, width: labelWidth, height: labelSize.height).flatted
            originY = detailTextLabel.frame.maxY + detailTextLabelInsets.bottom
        }
        
        if !actionButton.isHidden {
            if actionButtonSize == CGSize.zero {
                actionButton.sizeToFit()
            } else {
                actionButton.frame = CGRect(x: 0, y: 0, width: actionButtonSize.width, height: actionButtonSize.height)
            }
            actionButton.frame = actionButton.frame.setXY(actionButton.frame.minXHorizontallyCenter(in: contentView.bounds) + actionButtonInsets.left, originY + actionButtonInsets.top)
            originY = actionButton.frame.maxY + actionButtonInsets.bottom
        }
    }
    
    /// sizeThatContentViewFits
    private var sizeThatContentViewFits: CGSize {
        
        let resultWidth = scrollView.bounds.width - scrollView.contentInset.left - scrollView.contentInset.right
        let imageViewHeight = iconImageView.sizeThatFits(CGSize(width: resultWidth, height: CGFloat.greatestFiniteMagnitude)).height + iconImageViewInsets.verticalValue
        let loadingViewHeight = loadingView.view.bounds.height + loadingViewInsets.verticalValue
        let textLabelHeight = titleLabel.sizeThatFits(CGSize(width: resultWidth, height: CGFloat.greatestFiniteMagnitude)).height + titleTextLabelInsets.verticalValue
        let detailTextLabelHeight = detailTextLabel.sizeThatFits(CGSize(width: resultWidth, height: CGFloat.greatestFiniteMagnitude)).height + detailTextLabelInsets.verticalValue
        var actionButtonHeight: CGFloat = 0
        if actionButtonSize == CGSize.zero {
            actionButtonHeight = actionButton.sizeThatFits(CGSize(width: resultWidth, height: CGFloat.greatestFiniteMagnitude)).height + actionButtonInsets.verticalValue
        } else {
            actionButtonHeight = actionButtonSize.height + actionButtonInsets.verticalValue
        }
        
        
        var resultHeight: CGFloat = 0
        if !iconImageView.isHidden {
            resultHeight += imageViewHeight
        }
        if !loadingView.view.isHidden {
            resultHeight += loadingViewHeight
        }
        if !titleLabel.isHidden {
            resultHeight += textLabelHeight
        }
        if !detailTextLabel.isHidden {
            resultHeight += detailTextLabelHeight
        }
        if !actionButton.isHidden {
            resultHeight += actionButtonHeight
        }
        
        return CGSize(width: resultWidth, height: resultHeight)
    }
    
    /// 显示或隐藏loading图标
    ///
    /// - Parameter hidden: hidden description
    public func setLoadingViewHidden(_ hidden: Bool) {
        loadingView.view.isHidden = hidden
        if hidden {
            loadingView.stopAnimating()
        } else {
            loadingView.startAnimating()
        }
        setNeedsLayout()
    }
    
    /**
     * 设置要显示的图片
     * @param image 要显示的图片，为nil则不显示
     */
    public func set(image: UIImage?) {
        iconImageView.image = image
        iconImageView.isHidden = image == nil
        setNeedsLayout()
    }
    
    /**
     * 设置提示语
     * @param text 提示语文本，若为nil则隐藏textLabel
     */
    public func setTitleLabel(_ text: String?) {
        titleLabel.text = text
        titleLabel.isHidden = text == nil
        setNeedsLayout()
    }
    
    
    /// 设置提示语
    /// - Parameter text: 富文本
    public func setTitleLabelAttributedText(_ text: NSAttributedString?) {
        titleLabel.attributedText = text
        titleLabel.isHidden = text == nil
        setNeedsLayout()
    }
    
    
    /// 设置详情提示语的文本
    /// - Parameter text: 富文本
    public func setDetailLabelAttributedText(_ text: NSAttributedString?) {
        detailTextLabel.attributedText = text
        detailTextLabel.isHidden = text == nil
        setNeedsLayout()
    }
    
    /**
     * 设置详细提示语的文本
     * @param text 详细提示语文本，若为nil则隐藏detailTextLabel
     */
    public func setDetailTextLabel(_ text: String?) {
        
        detailTextLabel.text = text
        detailTextLabel.isHidden = text == nil
        setNeedsLayout()
    }
    
    /**
     * 设置操作按钮的文本
     * @param title 操作按钮的文本，若为nil则隐藏actionButton
     */
    public func setActionButtonTitle(_ title: String?) {
        actionButton.setTitle(title, for: .normal)
        actionButton.isHidden = title == nil
        setNeedsLayout()
    }

    /// 设置按钮
    /// - Parameters:
    ///   - target:
    ///   - action:
    public func setActionButton(target: Any?, action: Selector){
        actionButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        setupLocation()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
