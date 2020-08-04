//
//  Indicator.swift
//  WZEmptyView
//
//  Created by xiaobin liu on 2020/1/15.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

/// MARK - IndicatorView
public typealias IndicatorView = UIView

/// MARK - 加载视图协议
public protocol Indicator {
    
    /// 开始动画
    func startAnimating()
    
    /// 停止动画
    func stopAnimating()
    
    /// 视图
    var view: IndicatorView { get }
}

/// MARK - ActivityIndicator
public final class ActivityIndicator: Indicator {

    /// 动画视图
    private let activityIndicatorView: UIActivityIndicatorView
    
    /// 动画次数
    private var animatingCount = 0
    
    /// 视图
    public var view: IndicatorView {
        return activityIndicatorView
    }
    
    /// 开始动画
    public func startAnimating() {
        if animatingCount == 0 {
            activityIndicatorView.startAnimating()
            activityIndicatorView.isHidden = false
        }
        animatingCount += 1
    }
    
    
    /// 停止动画
    public func stopAnimating() {
        animatingCount = max(animatingCount - 1, 0)
        if animatingCount == 0 {
            activityIndicatorView.stopAnimating()
            activityIndicatorView.isHidden = true
        }
    }
    
    
    /// 初始化
    init() {
        let indicatorStyle: UIActivityIndicatorView.Style
        if #available(iOS 13.0, * ) {
            indicatorStyle = UIActivityIndicatorView.Style.medium
        } else {
            indicatorStyle = UIActivityIndicatorView.Style.gray
        }
        activityIndicatorView = UIActivityIndicatorView(style: indicatorStyle)
    }
}
