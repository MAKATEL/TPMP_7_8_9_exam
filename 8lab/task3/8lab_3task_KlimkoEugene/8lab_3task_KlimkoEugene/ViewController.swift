//
//  ViewController.swift
//  8lab_3task_KlimkoEugene
//
//  Created by MacOSExi on 16.05.24.
//  Copyright © 2024 MacOSExi. All rights reserved.
//

import UIKit
import SceneKit

class ViewController: UIViewController {
    
    var tubeNode: SCNNode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Создаем SCNView
        let sceneView = SCNView(frame: self.view.bounds)
        sceneView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(sceneView)
        
        // Создаем сцену
        let scene = SCNScene()
        sceneView.scene = scene
        
        // Создаем камеру
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 20)
        scene.rootNode.addChildNode(cameraNode)
        
        // Создаем основной источник света
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.light?.intensity = 500 // Уменьшаем интенсивность света, чтобы тень не была такой темной
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)
        
        // Создаем дополнительный рассеянный свет
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = .ambient
        ambientLightNode.light?.intensity = 200 // Интенсивность рассеянного света
        ambientLightNode.light?.color = UIColor.white
        scene.rootNode.addChildNode(ambientLightNode)
        
        // Создаем геометрию трубки
        let tubeGeometry = SCNTube(innerRadius: 1.0, outerRadius: 1.5, height: 3.0)
        
        // Создаем материал для трубки
        let tubeMaterial = SCNMaterial()
        tubeMaterial.diffuse.contents = UIColor.blue
        tubeGeometry.materials = [tubeMaterial]
        
        // Создаем узел трубки и добавляем его в сцену
        tubeNode = SCNNode(geometry: tubeGeometry)
        scene.rootNode.addChildNode(tubeNode)
        
        // Настройка SceneView
        sceneView.allowsCameraControl = true
        sceneView.backgroundColor = UIColor.black
        
        // Добавление распознавателя жестов для масштабирования
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        sceneView.addGestureRecognizer(pinchGesture)
    }
    
    @objc func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        let scale = Float(gesture.scale)
        tubeNode.scale = SCNVector3(x: scale, y: scale, z: scale)
        gesture.scale = 1.0
    }
}
