//
//  TableCell.swift
//  46.MutiThread
//
//  Created by jackfrow on 2021/4/28.
//

import UIKit

class TestCell: JRBaseCell {

    override var model: JRBaseModel{
        set {
//            self.model = newValue
            if let model = newValue as? TestModel {
                self.textLabel?.text = model.title
            }
        }
        get{
            return self.model
        }
    }
         
}
