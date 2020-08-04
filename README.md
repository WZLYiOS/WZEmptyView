# 我主良缘WZEmptyView

## Requirements:
- **iOS** 9.0+
- Xcode 10.0+
- Swift 5.0+ 


## Installation Cocoapods
<pre><code class="ruby language-ruby">pod 'WZEmptyView', '~> 1.0.0'</code></pre>
<pre><code class="ruby language-ruby">pod 'WZEmptyView/Binary', '~> 1.0.0'</code></pre>


## Use
```swift
  /// 显示emptyView，将其放到tableFooterView。emptyView的系列接口可以按需进行重写
    @objc func showEmptyView() {
        if emptyView == nil {
            emptyView = WZEmptyView(frame: view.bounds)
        }
        view.addSubview(emptyView!)
    }
    
    /**
     *  隐藏emptyView
     */
    @objc func hideEmptyView() {
        emptyView?.removeFromSuperview()
    }
    
    /**
     *  显示loading的emptyView
     */
    func showEmptyViewWithLoading() {
        showEmptyView()
        guard let emptyView = emptyView else { return }
        emptyView.set(image: nil)
        emptyView.setLoadingViewHidden(false)
        emptyView.setTextLabel(nil)
        emptyView.setDetailTextLabel(nil)
        emptyView.setActionButtonTitle(nil)
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
        guard let emptyView = emptyView else { return }
        emptyView.setLoadingViewHidden(!showLoading)
        emptyView.set(image: image)
        emptyView.setTextLabel(text)
        emptyView.setDetailTextLabel(detailText)
        emptyView.actionButtonTitleNormalColor = UIColor.red
        emptyView.setActionButtonTitle(buttonTitle)
        emptyView.actionButton.removeTarget(nil, action: nil, for: .allEvents)
        guard let buttonAction = buttonAction else { return }
        emptyView.actionButton.addTarget(self, action: buttonAction, for: .touchUpInside)
    }
```


## License
WZEmptyView is released under an MIT license. See [LICENSE](LICENSE) for more information.

