//
//  TagBubbleViewController.swift
//  Test2
//
//  Created by 강인희 on 2023/04/05.
//

import UIKit

class TagBubbleViewController: UIViewController {
  private lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.backgroundColor = .black
    imageView.contentMode = .scaleAspectFit
    imageView.isUserInteractionEnabled = true
    imageView.image = UIImage(imageLiteralResourceName: "3guys")
    
    return imageView
  }()
  
  private lazy var bubbleView1 = TagBubbleView(message: "i")
  private lazy var bubbleView2 = TagBubbleView(message: "love")
  private lazy var bubbleView3 = TagBubbleView(message: "you")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    
    self.view.addSubview(imageView)
    self.view.addSubview(bubbleView1)
    self.view.addSubview(bubbleView2)
    self.view.addSubview(bubbleView3)
    
    NSLayoutConstraint.activate([
      imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
      imageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -20),
      imageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, constant: -50),
      
      bubbleView1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      bubbleView1.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
      
      bubbleView2.topAnchor.constraint(equalTo: self.bubbleView1.bottomAnchor, constant: 10),
      bubbleView2.centerXAnchor.constraint(equalTo: self.bubbleView1.centerXAnchor),
     
      bubbleView3.topAnchor.constraint(equalTo: self.bubbleView2.bottomAnchor, constant: 10),
      bubbleView3.centerXAnchor.constraint(equalTo: self.bubbleView1.centerXAnchor),
    ])
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
    imageView.addGestureRecognizer(tapGesture)
  }
  
  @objc private func didTapImage() {
      bubbleView1.isHidden.toggle()
      bubbleView2.isHidden.toggle()
      bubbleView3.isHidden.toggle()
  }
}
