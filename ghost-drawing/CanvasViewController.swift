//
//  CanvasViewController.swift
//  ghost-drawing
//
//  Created by Andrew on 2022-07-20.
//

import UIKit

class CanvasViewController: UIViewController {
    private(set) lazy var canvasView: CanvasView = makeCanvasView()
    private(set) lazy var buttonsStackView: UIStackView = makeButtonsStackView()
    
    private let drawingColors: [UIColor] = [.red, .blue, .green, .white]
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [canvasView, buttonsStackView]
            .forEach(view.addSubview(_:))
        
        view.bringSubviewToFront(canvasView)
        setupConstraints()
        populateDrawingButtons()
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
    }
    
    // MARK: - Methods
    private func setupConstraints() {
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            canvasView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            canvasView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            canvasView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            canvasView.bottomAnchor.constraint(equalTo: buttonsStackView.topAnchor),
            
            buttonsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 50),
            buttonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func populateDrawingButtons() {
        drawingColors.enumerated().forEach { (position, color) in
            let button = UIButton()
            button.tag = position
            button.backgroundColor = color
            button.layer.cornerRadius = 25
            
            if color == UIColor.white {
                button.setTitle("Eraser", for: .normal)
                button.setTitleColor(.black, for: .normal)
                button.layer.borderWidth = 2
                button.layer.borderColor = UIColor.black.cgColor
            }
            
            button.addTarget(self, action: #selector(drawingButtonTapped(_:)), for: .touchUpInside)
            self.buttonsStackView.addArrangedSubview(button)
        }
    }
    
    @objc private func drawingButtonTapped(_ sender: UIButton) {
        canvasView.strokeColor = drawingColors[sender.tag]
    }
}

// MARK: - CanvasViewController view extensions
private extension CanvasViewController {
    func makeCanvasView() -> CanvasView {
        let canvasView = CanvasView()
        canvasView.backgroundColor = .white
        return canvasView
    }
    
    func makeButtonsStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.backgroundColor = .white
        return stackView
    }
}

