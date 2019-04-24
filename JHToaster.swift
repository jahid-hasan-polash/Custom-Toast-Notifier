//
//  JHToaster.swift
//  Opsonin Pharma Manual
//
//  Created by JAHID HASAN POLASH on 24/4/19.
//  Copyright © 2019 InfancyIT. All rights reserved.
//

import UIKit

class JHToaster: UIView {
    open var bgColor: UIColor? {
        didSet {
            backgroundColor = bgColor
        }
    }
    open var image: UIImage? {
        didSet {
            setImage(with: image)
        }
    }
    open var text: String? {
        didSet {
            setLabel(with: text)
        }
    }
    open var textColor: UIColor? {
        didSet {
            label?.textColor = textColor ?? .black
        }
    }
    
    private var imageView: UIImageView?
    private var label: UILabel?
    
    private func setImage(with image: UIImage?) {
        if let image = image {
            imageView = UIImageView(image: image)
            self.addSubview(imageView!)
            imageView?.translatesAutoresizingMaskIntoConstraints = false
            imageView?.contentMode = .scaleAspectFit
            [imageView?.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
             imageView?.centerYAnchor.constraint(equalTo: centerYAnchor),
             imageView?.heightAnchor.constraint(equalToConstant: 30),
             imageView?.widthAnchor.constraint(equalToConstant: 30)]
                .forEach { $0?.isActive = true }
        }
    }
    
    private func setLabel(with text: String?) {
        if let text = text {
            label = UILabel()
            label?.numberOfLines = 0
            label?.text = text
            self.addSubview(label!)
            label?.translatesAutoresizingMaskIntoConstraints = false
            if let imageView = self.imageView {
                label?.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8).isActive = true
            } else {
                label?.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
                label?.textAlignment = .center
            }
            [label?.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
             label?.centerYAnchor.constraint(equalTo: centerYAnchor)].forEach { $0?.isActive = true }
        }
    }
    
    convenience init(backgroundColor: UIColor?) {
        self.init()
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 2
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowOpacity = 0.7
        self.backgroundColor = backgroundColor
    }
}

class JHToasterPresenter {
    class func present(in view: UIView, with image: UIImage?, with text: String?, where backgroundColor: UIColor? = .white) {
        let toaster = JHToaster(backgroundColor: backgroundColor)
        toaster.translatesAutoresizingMaskIntoConstraints = false
        toaster.image = image
        toaster.text = text
        view.addSubview(toaster)
        [toaster.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
         toaster.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
         toaster.heightAnchor.constraint(equalToConstant: 80)].forEach { $0.isActive = true }
        let bottomConstraint = NSLayoutConstraint(item: toaster, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 60)
        bottomConstraint.isActive = true
        view.layoutIfNeeded()
        bottomConstraint.constant = -24
        UIView.animate(withDuration: 0.3, animations: {
            view.layoutIfNeeded()
        }) { _ in
            UIView.animate(withDuration: 2.5, animations: {
                toaster.alpha = 0
            }, completion: { _ in
                toaster.removeFromSuperview()
            })
        }
    }
}
