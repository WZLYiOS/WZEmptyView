//
//  Help.swift
//  WZEmptyView
//
//  Created by xiaobin liu on 2020/1/15.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit


// MARK: - Description
internal extension CGRect {
    
    /// 对CGRect的x/y、width/height都调用一次flat，以保证像素对齐
    var flatted: CGRect {
        return CGRect(x: flat(minX), y: flat(minY), width: flat(width), height: flat(height))
    }
    
    
    func setXY(_ x: CGFloat, _ y: CGFloat) -> CGRect {
        var result = self
        result.origin.x = flat(x)
        result.origin.y = flat(y)
        return result
    }
    
    /// 计算view的水平居中，传入父view和子view的frame，返回子view在水平居中时的x值
    func minXHorizontallyCenter(in parentRect: CGRect) -> CGFloat {
        return flat((parentRect.width - width) / 2.0)
    }
}

// MARK: - Description
internal extension CGSize {
    
    /// 将一个CGSize像素对齐
    var flatted: CGSize {
        return CGSize(width: flat(width), height: flat(height))
    }
}

extension UIEdgeInsets {
    
    /// 获取UIEdgeInsets在水平方向上的值
    var horizontalValue: CGFloat {
        return left + right
    }
    
    /// 获取UIEdgeInsets在垂直方向上的值
    var verticalValue: CGFloat {
        return top + bottom
    }
}


/**
 *  基于当前设备的屏幕倍数，对传进来的 floatValue 进行像素取整。
 *
 *  注意如果在 Core Graphic 绘图里使用时，要注意当前画布的倍数是否和设备屏幕倍数一致，若不一致，不可使用 flat() 函数，而应该用 flatSpecificScale
 */
fileprivate func flat(_ value: CGFloat) -> CGFloat {
    return flatSpecificScale(value, 0)
}

/**
 *  基于指定的倍数，对传进来的 floatValue 进行像素取整。若指定倍数为0，则表示以当前设备的屏幕倍数为准。
 *
 *  例如传进来 “2.1”，在 2x 倍数下会返回 2.5（0.5pt 对应 1px），在 3x 倍数下会返回 2.333（0.333pt 对应 1px）。
 */
fileprivate func flatSpecificScale(_ value: CGFloat, _ scale: CGFloat) -> CGFloat {
    let s = scale == 0 ? UIScreen.main.scale : scale
    return ceil(value * s) / s
}
