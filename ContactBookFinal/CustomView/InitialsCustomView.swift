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
       //backgroundColor = .red
     }
    
    override func draw(_ rect: CGRect) {
        guard let name = name else {
            return
        }
        self.layer.cornerRadius = rect.width / 2;
        self.layer.masksToBounds = true;
        let path = UIBezierPath(ovalIn: rect)
        self.backgroundColor = .random()

        self.backgroundColor!.setFill()
        path.fill()
        let attributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25.0)
        ]
        let text = NSAttributedString(string: name, attributes: attributes)
        let size: CGSize = text.size()
        let viewCenter = CGPoint(x:(rect.width - size.width)/2, y: (rect.height - size.height)/2)
        text.draw(at:viewCenter)
    }
    
    
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}




