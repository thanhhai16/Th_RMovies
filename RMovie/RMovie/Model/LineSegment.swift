//
//  LineSegment.swift
//  RMovie
//
//  Created by Hai on 1/3/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit

class LineSegment: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func animationLine(moveBack : Bool) {
        let currentX = self.frame.origin.x
        UIView.animate(withDuration: 0.5) {
            if moveBack {
                self.frame.origin.x = currentX - self.frame.width * 2
            }
            self.frame.origin.x = currentX + self.frame.width * 2
        }
    }
}
