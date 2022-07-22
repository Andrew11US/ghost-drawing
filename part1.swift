//
//  part1.swift
//  test1
//
//  Created by Andrew on 2022-07-22.
//

import UIKit

public enum Constants {
    struct CellIdentifier {
        static let someCell = "SomeCell"
    }
}

func isIPhone() -> Bool {
    UIDevice.current.userInterfaceIdiom == .phone
}

class SomeVC: UIViewController {
    @IBOutlet weak var collectionViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var detailViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var detailView: UIView!
    
    var detailVC: UIViewController?
    var dataArray: [Any]?
    
    // MARK: - View Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: Constants.CellIdentifier.someCell, bundle: nil), forCellWithReuseIdentifier: Constants.CellIdentifier.someCell)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Done", comment: "Done bar button"), style: .plain, target: self, action: #selector(dismissController))
        
        fetchData()
    }
    
    // MARK: - Actions
    @objc func dismissController () {
        dismiss(animated: true)
    }
    
    // MARK: - Methods
    func fetchData() {
        guard let url = URL(string: "testreq") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            guard error == nil else { return }
            guard let data = data else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                guard let itemsArray = json as? [Any] else { return }
                self.dataArray = itemsArray
            } catch let error {
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        task.resume()
    }
    
    func closeDetails() {
        detailViewWidthConstraint.constant = 0
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        } completion: { completed in
            self.detailView.removeFromSuperview()
        }
    }
    
    func showDetails() {
        detailViewWidthConstraint.constant = 100
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        } completion: { completed in
            self.view.addSubview(self.detailView)
        }
    }
}

// MARK: - SomeVC CollectionView extensions
extension SomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        var widthMultiplier: CGFloat = 0.2929
        if isIPhone() {
            widthMultiplier = 0.9
        }
        
        return CGSize(width: view.frame.width * widthMultiplier, height:  150.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
                        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        let frameWidth = (view.frame.width * 0.2929 * 3) + 84
        var minSpacing: CGFloat = (view.frame.width - frameWidth)/2
        if isIPhone() {
            minSpacing = 24
        }
        return minSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifier.someCell, for: indexPath)
        // TODO: - configure cell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showDetails()
    }
}
