//
//  CreatingController.swift
//  Journals-ios
//
//  Created by Aries Yang on 2017/12/8.
//  Copyright © 2017年 Aries Yang. All rights reserved.
//

import UIKit
import Firebase
import ImagePicker

class CreatingController: UIViewController {

    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var imagePickerButton: UIButton!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var contentTextField: UITextField!

    @IBOutlet weak var saveButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    }
}
