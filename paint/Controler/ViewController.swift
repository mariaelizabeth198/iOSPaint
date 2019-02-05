//
//  ViewController.swift
//  paint
//
//  Created by Maria Elizabeth Da Silva Bezerra on 05/02/2019.
//  Copyright © 2019 Maria Elizabeth. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let canvas = Canvas()
    
    fileprivate func setup() {
        view.addSubview(canvas)
        canvas.backgroundColor = .white
        canvas.frame = view.frame
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
