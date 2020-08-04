//
//  ViewController.swift
//  WZEmptyView
//
//  Created by LiuSky on 09/09/2019.
//  Copyright (c) 2019 LiuSky. All rights reserved.
//

import UIKit
import WZEmptyView

/// MARK - Demo
final class ViewController: UIViewController, EmptyViewControllerProtocol {

    /// 列表
    private lazy var tableView: UITableView = {
        let temTableView = UITableView()
        temTableView.backgroundColor = UIColor.white
        temTableView.rowHeight = 50
        temTableView.delegate = self
        temTableView.dataSource = self
        temTableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        temTableView.tableFooterView = UIView()
        temTableView.translatesAutoresizingMaskIntoConstraints = false
        return temTableView
    }()
    
    /// 当前self.emptyView是否显示
    var isEmptyViewShowing: Bool {
        return emptyView.superview != nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        configView()
        configLocation()
    }
    
    /// 配置视图
    private func configView() {
        view.addSubview(tableView)
    }
    
    /// 配置位置
    private func configLocation() {
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    /**
     *  显示loading的emptyView
     */
    func showEmptyViewWithLoading(isCustom custom: Bool) {
        
        if custom {
            showLoading(ImageIndicator(), title: "加载中...")
        } else {
            showLoading(title: "加载中...")
        }
    }

    /**
     *  显示带loading、image、text、detailText、button的emptyView，带了with 防止与 showEmptyView() 混淆
     */
    func showEmptyViewWith(showLoading: Bool = false,
                           image: UIImage? = nil,
                           text: String?,
                           detailText: String?,
                           buttonTitle: String?,
                           buttonAction: Selector?) {
        showEmptyView()
        
        emptyView.setLoadingViewHidden(!showLoading)
        emptyView.set(image: image)
        emptyView.setTitleLabel(text)
        emptyView.setDetailTextLabel(detailText)
        emptyView.actionButtonTitleNormalColor = UIColor.red
        emptyView.setActionButtonTitle(buttonTitle)
        //emptyView.actionButton.removeTarget(nil, action: nil, for: .allEvents)
        guard let buttonAction = buttonAction else { return }
        //emptyView.actionButton.addTarget(self, action: buttonAction, for: .touchUpInside)
    }

    @objc private func reload(_ sender: Any) {
        hideEmptyView()
        tableView.reloadData()
    }

    private func after() {
        DispatchQueue.main.asyncAfter(deadline:  .now() + 5.0) {
            self.hideEmptyView()
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isEmptyViewShowing ? 0 : 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")!
        if indexPath.row == 0 {
            cell.textLabel?.text = "显示loading"
        } else if indexPath.row == 1 {
            cell.textLabel?.text = "显示提示语"
        } else if indexPath.row == 2 {
            cell.textLabel?.text = "显示提示语及操作按钮"
        } else if indexPath.row == 3 {
            cell.textLabel?.text = "显示占位图及文字"
        } else if indexPath.row == 4 {
            cell.textLabel?.text = "自定义loading样式"
        }
        return cell
    }
}


// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            showEmptyViewWithLoading(isCustom: false)
        } else if indexPath.row == 1 {
            showEmptyViewWith(text: "联系人为空", detailText: "请到设置-隐私查看你的联系人权限设置", buttonTitle: nil, buttonAction: nil)
        } else if indexPath.row == 2 {
            showEmptyViewWith(text: "请求失败", detailText: "请检查网络连接", buttonTitle: "重试", buttonAction: #selector(reload(_:)))
        } else if indexPath.row == 3 {
            showEmptyViewWith(image: UIImage(named: "icon_grid_assetsManager"), text: nil, detailText: "图片间距可通过imageInsets来调整", buttonTitle: nil, buttonAction: nil)
        } else if indexPath.row == 4 {
            showEmptyViewWithLoading(isCustom: true)
        }
        tableView.reloadData()
        after()
    }
}

/// MARK -
final class ImageIndicator: Indicator {
    
    private let animationImageView: UIImageView
    
    func startAnimating() {
        animationImageView.startAnimating()
    }
    
    func stopAnimating() {
        animationImageView.stopAnimating()
    }
    
    var view: IndicatorView {
        return animationImageView
    }
    
    init() {
        
        animationImageView = UIImageView()
        animationImageView.animationImages = (1...60).compactMap { UIImage(named: "dropdown_anim__000\($0)") }
        animationImageView.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
    }
}
