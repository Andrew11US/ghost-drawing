//
//  CanvasViewController.swift
//  ghost-drawing
//
//  Created by Andrew on 2022-07-20.
//

import UIKit

class CanvasViewController: UIViewController {
    private(set) lazy var canvasView: CanvasView = makeCanvasView()
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(canvasView)
        view.bringSubviewToFront(canvasView)
        setupConstraints()
    }
    
    // MARK: - Methods
    private func setupConstraints() {
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            canvasView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            canvasView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            canvasView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            canvasView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

// MARK: - CanvasViewController extensions
private extension CanvasViewController {
    func makeCanvasView() -> CanvasView {
        let canvasView = CanvasView()
        canvasView.backgroundColor = .white
        return canvasView
    }
}

