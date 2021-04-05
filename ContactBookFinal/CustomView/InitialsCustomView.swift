//
//  InitialsCustomView.swift
//  ContactBookFinal
//
//  Created by Gushchin Ilya on 04.04.2021.
//

import UIKit

@IBDesignable
class InitialsCustomView: UIView {
    
    @IBOutlet var customView: UIView!
    
    @IBInspectable var outlineColor: UIColor = .blue
    
    var name: String? = nil
    
    override init(frame: CGRect) {
       super.init(frame: frame)
       setupView()
     }
     
     //initWithCode to init view from xib or storyboard
     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
       setupView()
     }
     
     //common func to init our view
     private func setupView() {
       backgroundColor = .red
     }
    
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = rect.width / 2;
        self.layer.masksToBounds = true;
        let path = UIBezierPath(ovalIn: rect)
        UIColor.blue.setFill()
        path.fill()
        
        let text = NSAttributedString(string: name ?? "")
        let textSize: CGSize = text.size()
        let viewCenter = CGPoint(x:(rect.width - textSize.width)/2, y: (rect.height - textSize.height)/2)
        text.draw(at:viewCenter)
    }
}




