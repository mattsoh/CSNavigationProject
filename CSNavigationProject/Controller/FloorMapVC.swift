//
//  FloorMapVC.swift
//  CSNavigationProject
//
//  Created by Matthew Soh on 2/2/23.
//

import UIKit


class FloorMapVC: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var panGestureRecogniser: UIPanGestureRecognizer!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var floorMapView: UIImageView!
        
    var chosenFloor = "SS1"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        panGestureRecogniser.addTarget(self, action: #selector(panGesture))
        floorMapView.image = UIImage(named: chosenFloor+"FloorMap")
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 4.0
        scrollView.delegate = self
        scrollView.isScrollEnabled = false
        panGestureRecogniser.isEnabled = true
        let panGesture = UIPanGestureRecognizer(target: self, action:#selector(panGesture))
        panGesture.cancelsTouchesInView = true
        scrollView.addGestureRecognizer(panGesture)
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return floorMapView
    }
    
    @objc func panGesture(gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: scrollView)
        var contentOffset = scrollView.contentOffset
        contentOffset.x -= translation.x
        contentOffset.y -= translation.y
        scrollView.contentOffset = contentOffset
        gestureRecognizer.setTranslation(.zero, in: scrollView)
    }

    
}
