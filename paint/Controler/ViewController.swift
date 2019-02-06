//
//  ViewController.swift
//  paint
//
//  Created by Maria Elizabeth Da Silva Bezerra on 05/02/2019.
//  Copyright © 2019 Maria Elizabeth. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let canvas = Canvas()
    
    @objc private func handleUndo() {
        canvas.undo()
    }
    
    @objc private func handleClear() {
        canvas.clear()
    }
    
    @objc private func handleColorChange() {
        canvas.setStrokeColor(r: CGFloat(rSlider.value), g: CGFloat(gSlider.value), b: CGFloat(bSlider.value))
    }
    
    @objc private func handleStrokeWidthChange() {
        canvas.setStrokeWidth(width: strokeWidhtSlider.value)
    }
    
    private func getConfiguredButton(title: String, fontSize: Float, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: CGFloat(fontSize))
        button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
    
    private func getConfiguredRGBSlider(tintColor: UIColor) -> UISlider {
        let slider = UISlider(frame: CGRect(x: 5, y: 5, width: 5, height: 1))
        slider.minimumValue = 0
        slider.maximumValue = 255
        slider.value = 0
        slider.tintColor = tintColor
        slider.addTarget(self, action: #selector(handleColorChange), for: .valueChanged)
        return slider
    }
    
    private func getConfiguredStrokeWidhtSlider() -> UISlider{
        let slider = UISlider(frame: CGRect(x: 5, y: 5, width: 5, height: 1))
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 1
        slider.tintColor = .black
        slider.addTarget(self, action: #selector(handleStrokeWidthChange), for: .valueChanged)
        
        return slider
    }
    
    lazy var undoButton: UIButton = {
        return getConfiguredButton(title:"Undo", fontSize:14, action: #selector(handleUndo))
    }()
    
    lazy var clearButton: UIButton = {
        return getConfiguredButton(title:"Clear", fontSize:14, action: #selector(handleClear))
    }()
    
    lazy var rSlider: UISlider = {
        return getConfiguredRGBSlider(tintColor: .red)
    }()
    
    lazy var gSlider: UISlider = {
        return getConfiguredRGBSlider(tintColor: .green)
    }()
    
    lazy var bSlider: UISlider = {
        return getConfiguredRGBSlider(tintColor: .blue)
    }()
    
    lazy var strokeWidhtSlider: UISlider = {
        return getConfiguredStrokeWidhtSlider()
    }()
    
    override func loadView() {
        self.view = canvas
    } 
    
    private func configureStackViewPosition(_ stackView: UIStackView) {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func setupLayout() {
        let rgbStackView = UIStackView(arrangedSubviews: [
            rSlider,
            gSlider,
            bSlider,
            strokeWidhtSlider
            ])
    
        rgbStackView.distribution = .fillEqually
        rgbStackView.axis = UILayoutConstraintAxis.vertical
        
        let stackView = UIStackView(arrangedSubviews: [
            rgbStackView,
            undoButton,
            clearButton
            ])
        
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        configureStackViewPosition(stackView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
