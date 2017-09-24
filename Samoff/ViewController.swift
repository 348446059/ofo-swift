//
//  ViewController.swift
//  Samoff
//
//  Created by libo on 2017/9/10.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit
import SWRevealViewController
import FTIndicator

class ViewController: UIViewController,MAMapViewDelegate,AMapSearchDelegate,AMapNaviWalkManagerDelegate{
    var mapView :MAMapView!
    var search : AMapSearchAPI!
    var pin:MyPinAnnotation!
    var pinView :MAPinAnnotationView!
    var nearBySearch = true
    var start,end :CLLocationCoordinate2D!
    var walkManager: AMapNaviWalkManager!
    
    
    @IBOutlet weak var panelView: UIView!
    @IBAction func locationBtnTap(_ sender: UIButton) {
        nearBySearch = true
        searchBikeNearBy()
    }
    
    //搜索周边的小黄车
    func searchBikeNearBy()  {
        searchCustomLocation(mapView.userLocation.coordinate)
    }
    func searchCustomLocation(_ center:CLLocationCoordinate2D) {
        let request = AMapPOIAroundSearchRequest()
        request.location = AMapGeoPoint.location(withLatitude: CGFloat(center.latitude), longitude: CGFloat(center.longitude))
        request.keywords = "餐馆"
        request.radius = 1000
        request.requireExtension = true
        search.aMapPOIAroundSearch(request)
        
    }
   
     override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        mapView = MAMapView(frame: view.bounds)
        mapView.delegate = self
        AMapServices.shared().enableHTTPS = true
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.zoomLevel = 17
        
        search = AMapSearchAPI()
        search.delegate = self
        walkManager = AMapNaviWalkManager()
        walkManager.delegate = self
        
        view.addSubview(mapView)
        view.bringSubview(toFront: panelView)
        self.navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "ofoLogo"))
        self.navigationItem.leftBarButtonItem?.image = #imageLiteral(resourceName: "leftTopImage").withRenderingMode(.alwaysOriginal)
        self.navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "rightTopImage").withRenderingMode(.alwaysOriginal)
        if let revealVC = revealViewController() {
            revealVC.rightViewRevealWidth = 280
            navigationItem.leftBarButtonItem?.target = revealVC
            navigationItem.leftBarButtonItem?.action = #selector(SWRevealViewController.revealToggle(_:))
           view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
    }
    //MARK:--大头针动画
    func pinAnimation()  {
        //坠落效果 y轴加位移
        let endFrame = pinView.frame
        
        pinView.frame = endFrame.offsetBy(dx: 0, dy: -15)
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0, options: [], animations: {
            self.pinView.frame = endFrame
        }, completion: nil)
    }
    //MARK: -- MapView Delegate
    func mapView(_ mapView: MAMapView!, rendererFor overlay: MAOverlay!) -> MAOverlayRenderer! {
        if overlay is MAPolyline{
            pin.isLockedToScreen = false
            mapView.visibleMapRect = overlay.boundingMapRect
            
            let render = MAPolylineRenderer(overlay: overlay)
            render?.lineWidth = 8.0
            render?.strokeColor = UIColor.blue
            
            return render
        }
        return nil
    }
    
    func mapView(_ mapView: MAMapView!, didSelect view: MAAnnotationView!) {
        start = pin.coordinate
        end = view.annotation.coordinate
        
        let startPoint = AMapNaviPoint.location(withLatitude: CGFloat(start.latitude), longitude: CGFloat(start.longitude))!
        
        let endPoint = AMapNaviPoint.location(withLatitude: CGFloat(end.latitude), longitude: CGFloat(end.longitude))!
      
        walkManager.calculateWalkRoute(withStart: [startPoint], end: [endPoint])
    }
    func mapView(_ mapView: MAMapView!, didAddAnnotationViews views: [Any]!) {
        let aviews = views as! [MAAnnotationView]
        
        
        for aview in aviews {
            guard aview.annotation is MAPointAnnotation else{
                continue
            }
            aview.transform = CGAffineTransform(scaleX: 0, y: 0)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [], animations: {
                aview.transform = .identity
            }, completion: nil)
        }
    }
    
   
    /// 用户移动地图
    ///
    /// - Parameters:
    ///   - mapView: mapView
    ///   - wasUserAction: 用户是否移动
    func mapView(_ mapView: MAMapView!, mapDidMoveByUser wasUserAction: Bool) {
        if wasUserAction {
            pin.isLockedToScreen = true
            pinAnimation()
            searchCustomLocation(mapView.centerCoordinate)
        }
    }
    /// 地图初始化完成后
    ///
    /// - Parameter mapView: mapView
    func mapInitComplete(_ mapView: MAMapView!) {
        pin = MyPinAnnotation()
        pin.coordinate = mapView.centerCoordinate
        pin.lockedScreenPoint = CGPoint(x: view.bounds.width/2, y: view.bounds.height/2)
        pin.isLockedToScreen = true
        
        mapView.addAnnotation(pin)
        mapView.showAnnotations([pin], animated: true)
        searchBikeNearBy()
    }
    /// 自定义大头针视图
    ///
    /// - Parameters:
    ///   - mapView: mapView
    ///   - annotation: 大头针
    /// - Returns: 大头针标注视图
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        if annotation is MAUserLocation {
            return nil
        }
        
        if annotation is MyPinAnnotation{
            let reuseid = "anchor"
            var av = mapView.dequeueReusableAnnotationView(withIdentifier: reuseid)
            if av == nil{
                av = MAPinAnnotationView(annotation: annotation, reuseIdentifier: reuseid)
            }
            av?.image = #imageLiteral(resourceName: "homePage_wholeAnchor")
            av?.canShowCallout = false
            
            pinView = av as! MAPinAnnotationView
            return av
        }
        let reuseid = "myid"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseid) as? MAPinAnnotationView
        if annotationView == nil {
            annotationView = MAPinAnnotationView(annotation:annotation,reuseIdentifier:reuseid)
        }
        if annotation.title == "正常可用" {
           annotationView?.image = #imageLiteral(resourceName: "HomePage_nearbyBike")
        }else{
             annotationView?.image = #imageLiteral(resourceName: "HomePage_nearbyBikeRedPacket")
            
        }
        annotationView?.canShowCallout = true
        annotationView?.animatesDrop = true
        return annotationView
    }

    //MARK: -Map Search Delegate
    //搜索周边完成--回调函数
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        guard response.count > 0 else {
            print("周边没有小黄车")
            return
        }
        var annotations:[MAPointAnnotation] = []
        
        annotations = response.pois.map{
            let annotation = MAPointAnnotation()
            
            annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees($0.location.latitude), longitude:CLLocationDegrees($0.location.longitude))
           
            if $0.distance < 400{
                
                annotation.title = "红包区域内开锁任意小黄车"
                annotation.subtitle = "骑行10分钟即得现金红包"
            }else{
                annotation.title = "正常可用"
            }
            
            
            return annotation
        }
        mapView.addAnnotations(annotations)
        if nearBySearch{
            mapView.showAnnotations(annotations, animated: true)
            nearBySearch = !nearBySearch
        }
       
    }

    //MARK:导航代理
    func walkManager(onCalculateRouteSuccess walkManager: AMapNaviWalkManager) {
        mapView.removeOverlays(mapView.overlays)
        var coordinate = walkManager.naviRoute!.routeCoordinates.map {
            return CLLocationCoordinate2D(latitude:CLLocationDegrees( $0.latitude), longitude: CLLocationDegrees($0.longitude))
        }
        
        let polyline = MAPolyline(coordinates: &coordinate, count: UInt(coordinate.count))
        
        mapView.add(polyline)
        
        //提示用时时间
        let walkMintue = walkManager.naviRoute!.routeTime / 60
        
        var timeDesc = "1分钟内"
        if walkMintue > 0{
            timeDesc = walkMintue.description + "分钟"
        }
        
        let hitTitle = "步行"+timeDesc
        let hintSubtitle = "距离"+walkManager.naviRoute!.routeLength.description+"米"
        
     FTIndicator.setIndicatorStyle(.dark)
      
        FTIndicator.showNotification(with:#imageLiteral(resourceName: "clock"), title: hitTitle, message: hintSubtitle)
        
        
    }
    
    func walkManager(_ walkManager: AMapNaviWalkManager, onCalculateRouteFailure error: Error) {
        print(error)
    }
}

