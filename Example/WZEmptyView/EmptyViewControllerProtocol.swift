//
//  EmptyViewControllerProtocol.swift
//  WZEmptyView
//
//  Created by xiaobin liu on 2020/1/15.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import WZEmptyView

// MARK: - Associated Object
private var emptyViewKey: Void?

/// MARK - LoadViewProtocol
public protocol EmptyViewControllerProtocol: NSObjectProtocol {
    
    /// 显示加载
    /// - Parameters:
    ///   - view: view
    ///   - title: title
    func showLoading(_ view: Indicator?, title: String?)
    
    /// 显示空视图
    func showEmptyView()

    /// 隐藏空视图
    func hideEmptyView()
}

/// MARK - UIViewController 扩展
public extension EmptyViewControllerProtocol where Self: UIViewController {

    /// 空视图
    var emptyView: EmptyView {
        get {
            
            if let temView = objc_getAssociatedObject(self, &emptyViewKey) as? EmptyView {
                return temView
            } else {
                self.emptyView = EmptyView(frame: view.bounds)
                return self.emptyView
            }
        }
        set {
            objc_setAssociatedObject(self, &emptyViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    
    /// 显示加载中...
    /// - Parameters:
    ///   - view: 加载动画协议
    ///   - title: 标题
    func showLoading(_ view: Indicator? = nil, title: String? = nil) {
        
        setup()
        if let temView = view {
            emptyView.loadingView = temView
        }
        emptyView.setTitleLabel(title)
        emptyView.set(image: nil)
        emptyView.setLoadingViewHidden(false)
        emptyView.loadingViewInsets = UIEdgeInsets(top: 0, left: 0, bottom: 18, right: 0)
        emptyView.setDetailTextLabel(nil)
        emptyView.setActionButtonTitle(nil)
    }
    

    /// 显示空视图
    func showEmptyView() {
        view.addSubview(emptyView)
    }

    /// 隐藏视图
    func hideEmptyView() {
        emptyView.removeFromSuperview()
    }
    
    
    /// 设置
    private func setup() {
        view.addSubview(emptyView)
    }
}
