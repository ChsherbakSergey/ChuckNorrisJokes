//
//  LayoutGuideProvider.swift
//  ChuckNorrisJokes
//
//  Created by Sergey on 1/20/21.
//

import UIKit

protocol LayoutGuideProvider {
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
}

extension UIView: LayoutGuideProvider { }
extension UILayoutGuide: LayoutGuideProvider { }

extension UIView {
    var compatibleSafeAreaLayoutGuide: LayoutGuideProvider {
        if #available(iOS 11, *) {
            return safeAreaLayoutGuide
        } else {
            return self
        }
    }
}
