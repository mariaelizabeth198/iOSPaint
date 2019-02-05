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
    
    let undoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Undo", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleUndo), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func handleUndo() {
        canvas.undo()
    }
    
    let clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Clear", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleClear), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func handleClear() {
        canvas.clear()
    }
    
    let rSlider: UISlider = {
        let slider = UISlider(frame: CGRect(x: 20, y: 100, width: 5, height: 1))
        slider.minimumValue = 0
        slider.maximumValue = 255
        slider.value = 0
        slider.tintColor = .red
        slider.addTarget(self, action: #selector(updateColor), for: .valueChanged)
        
        return slider
    }()
    
    let gSlider: UISlider = {
        let slider = UISlider(frame: CGRect(x: 20, y: 100, width: 5, height: 1))
        slider.minimumValue = 0
        slider.maximumValue = 255
        slider.value = 0
        slider.tintColor = .green
        slider.addTarget(self, action: #selector(updateColor), for: .valueChanged)
        return slider
    }()
    
    let bSlider: UISlider = {
        let slider = UISlider(frame: CGRect(x: 20, y: 100, width: 5, height: 1))
        slider.minimumValue = 0
        slider.maximumValue = 255
        slider.value = 0
        slider.tintColor = .blue
        slider.addTarget(self, action: #selector(updateColor), for: .valueChanged)
        return slider
    }()
    
    @objc fileprivate func updateColor() {
        canvas.changeLineColor(r: CGFloat(rSlider.value), g: CGFloat(gSlider.value), b: CGFloat(bSlider.value))
    }
    
    override func loadView() {
        self.view = canvas
    } 
    
    fileprivate func setupLayout() {
        
        let rgbStackView = UIStackView(arrangedSubviews: [
            rSlider, gSlider, bSlider])
    
        rgbStackView.distribution = .fillEqually
        rgbStackView.axis = UILayoutConstraintAxis.vertical
        
        let stackView = UIStackView(arrangedSubviews: [
            undoButton,
            clearButton,
            rgbStackView
            ])
        
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
