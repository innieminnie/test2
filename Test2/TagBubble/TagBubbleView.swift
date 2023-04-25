//
//  TagBubbleView.swift
//  Test2
//
//  Created by 강인희 on 2023/04/04.
//

import UIKit

class TagBubbleView: UIView {
  override var bounds: CGRect { // layoutsubviews 와 비교하기
    didSet {
      addUpperArrow()
      addLowerArrow()
    }
  }
  
  private let bubbleWidth = 44
  private let bubbleHeight = 35
  
  private let upperShape = CAShapeLayer()
  private let lowerShape = CAShapeLayer()
  
  private let upperPath = UIBezierPath()
  private let lowerPath = UIBezierPath()
  
  private lazy var messageLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 17)
    
    return label
  }()
  
  init(message: String) {
    super.init(frame: .zero)
    self.translatesAutoresizingMaskIntoConstraints = false
    
    self.backgroundColor = UIColor.systemGray
    
    self.layer.opacity = 0.8
    self.layer.masksToBounds = false
    self.layer.cornerRadius = 8
    
    self.isHidden = true
    lowerShape.isHidden = true
    
    let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(moveBubbleLocation(_:)))
    self.addGestureRecognizer(longPressGesture)
    
    NSLayoutConstraint.activate([
      self.widthAnchor.constraint(greaterThanOrEqualToConstant: CGFloat(bubbleWidth)),
      self.widthAnchor.constraint(lessThanOrEqualToConstant: 100),
      self.heightAnchor.constraint(greaterThanOrEqualToConstant: CGFloat(bubbleHeight)),
    ])
    
    self.addSubview(messageLabel)
    self.addLabel(message: message)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override var isHidden: Bool {
    didSet {
      if !isHidden {
        UIView.animateKeyframes(withDuration: 0.5, delay: 0) {
          UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1 / 3) {
            self.transform = CGAffineTransformMakeScale(1.2, 1.2)
          }
          
          UIView.addKeyframe(withRelativeStartTime: 1 / 3, relativeDuration: 1 / 3) {
            self.transform = CGAffineTransformMakeScale(0.8, 0.8)
          }
          
          UIView.addKeyframe(withRelativeStartTime: 2 / 3, relativeDuration: 1 / 3) {
            self.transform = CGAffineTransformIdentity
          }
        }
      }
    }
  }
  
  private func addLabel(message: String) {
    messageLabel.text = message
    
    NSLayoutConstraint.activate([
      messageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
      messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
      messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
      messageLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
    ])
  }
  
  @objc private func moveBubbleLocation(_ recognizer: UILongPressGestureRecognizer) {
    switch recognizer.state {
    case .began, .changed:
      var center = self.center
      guard let superView = superview else { return }
      
      center.x = recognizer.location(in: superView).x
      center.y = recognizer.location(in: superView).y
      self.center = center
      
      if center.y < superView.frame.midY {
        upperShape.isHidden = true
        lowerShape.isHidden = false
      } else {
        upperShape.isHidden = false
        lowerShape.isHidden = true
      }
      
    default:
      break
    }
  }
  
  private func addUpperArrow() {
    upperPath.move(to: CGPoint(x: bounds.midX - 10, y: 1))
    upperPath.addLine(to: CGPoint(x: bounds.midX, y: -10))
    upperPath.addLine(to: CGPoint(x: bounds.midX + 10, y: 1))
    upperPath.close()
    
    upperShape.path = upperPath.cgPath
    upperShape.fillColor = UIColor.systemGray.cgColor
    self.layer.addSublayer(upperShape)
  }
  
  private func addLowerArrow() {
    lowerPath.move(to: CGPoint(x: bounds.midX - 10, y: bounds.maxY - 1))
    lowerPath.addLine(to: CGPoint(x: bounds.midX, y: bounds.maxY + 10))
    lowerPath.addLine(to: CGPoint(x: bounds.midX + 10, y: bounds.maxY - 1))
    lowerPath.close()
    
    lowerShape.path = lowerPath.cgPath
    lowerShape.fillColor = UIColor.systemGray.cgColor
    self.layer.addSublayer(lowerShape)
  }
}
