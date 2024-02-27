//
//  CANavitigationController.swift
//  cashACEProject
//
//  Created by Apple on 2023/6/8.
//

import UIKit
import Hue
class LendEasy_NavitigationController: UINavigationController,UIGestureRecognizerDelegate{
    override func viewDidLoad() {
        super.viewDidLoad()        
        let navApperance = UINavigationBar.appearance()
        navApperance.tintColor = UIColor.init(hex: "222222")
        navApperance.barTintColor = UIColor.white
        navApperance.isTranslucent = false
        navApperance.shadowImage = UIImage()
        navApperance.setBackgroundImage(UIImage.imageFromColor(color: UIColor.white), for:.default)
        
        if #available(iOS 15.0, *) {
            let appearance : UINavigationBarAppearance = UINavigationBarAppearance()
            appearance.backgroundColor = UIColor.white
            appearance.shadowImage = UIImage()
            appearance.titleTextAttributes = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18),NSAttributedString.Key.foregroundColor : UIColor.init(hex: "222222")]
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            UINavigationBar.appearance().standardAppearance = appearance
        }
        
        if self.responds(to: #selector(getter: interactivePopGestureRecognizer)) {
            self.interactivePopGestureRecognizer?.delegate = self
            self.interactivePopGestureRecognizer?.isEnabled = true
        }
        
    }
    
    func imageFromColor(color: UIColor, viewSize: CGSize) -> UIImage{
           let rect: CGRect = CGRect(x: 0, y: 0, width: viewSize.width, height: viewSize.height)
           UIGraphicsBeginImageContext(rect.size)
           let context: CGContext = UIGraphicsGetCurrentContext()!
           context.setFillColor(color.cgColor)
           context.fill(rect)

           let image = UIGraphicsGetImageFromCurrentImageContext()
           UIGraphicsGetCurrentContext()
           return image!
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return self.viewControllers.count != 1 && gestureRecognizer.isKind(of: UIScreenEdgePanGestureRecognizer.self)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.viewControllers.count != 1 && gestureRecognizer.isKind(of: UIScreenEdgePanGestureRecognizer.self)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.children.count > 0 {
            if self.responds(to: #selector(getter: interactivePopGestureRecognizer)) {
                viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "back"), style: .done, target: self, action:#selector(backAction))
                self.interactivePopGestureRecognizer?.delegate = self
                self.interactivePopGestureRecognizer?.isEnabled = true
            }
        }else{
            viewController.hidesBottomBarWhenPushed = false;
        }
        
        if self.viewControllers.count == 1 {
            viewController.hidesBottomBarWhenPushed = true
        }else{
            viewController.hidesBottomBarWhenPushed = false
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc func backAction(){
        self.popViewController(animated: true)
    }
}
