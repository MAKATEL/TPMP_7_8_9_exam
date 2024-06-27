import UIKit

class ViewController: UIViewController {

    let octagon = CAShapeLayer()
    var originalPosition: CGPoint = .zero
    
    // Объявляем кнопки
    var buttonNoAnimation: UIButton!
    var buttonScale: UIButton!
    var buttonMove: UIButton!
    var buttonRoundCorners: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Рисуем восьмиугольник
        let initialRadius: CGFloat = 50
        octagon.path = octagonPathWithCenter(center: .zero, radius: initialRadius).cgPath
        octagon.fillColor = UIColor.purple.cgColor
        
        let frame = view.bounds
        
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = [UIColor.blue.cgColor, UIColor.yellow.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        
        self.view.layer.addSublayer(gradient)
        self.view.layer.addSublayer(octagon)
        
        // Создаем кнопки
        buttonNoAnimation = createButton(title: "No Animation", action: #selector(stopAnimation))
        buttonScale = createButton(title: "Scale", action: #selector(scaleOctagon))
        buttonMove = createButton(title: "Move", action: #selector(moveOctagon))
        buttonRoundCorners = createButton(title: "Round Corners", action: #selector(roundCorners))
        
        // Располагаем кнопки
        arrangeButtons()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Устанавливаем позицию восьмиугольника в центр экрана
        let initialCenter = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        octagon.position = initialCenter
        originalPosition = initialCenter
    }
  
    func octagonPathWithCenter(center: CGPoint, radius: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        for i in 0..<8 {
            let angle = CGFloat(Double.pi / 4.0 * Double(i))
            let x = center.x + radius * cos(angle)
            let y = center.y + radius * sin(angle)
            if i == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        path.close()
        return path
    }
    
    func createButton(title: String, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
        return button
    }
    
    func arrangeButtons() {
        let stackView = UIStackView(arrangedSubviews: [buttonNoAnimation, buttonScale, buttonMove, buttonRoundCorners])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    @objc func stopAnimation() {
        octagon.removeAllAnimations()
        octagon.position = originalPosition
        octagon.setAffineTransform(CGAffineTransform.identity)
        octagon.path = octagonPathWithCenter(center: CGPoint.zero, radius: 50).cgPath
    }
    
    @objc func scaleOctagon() {
        octagon.removeAllAnimations()
        let scale = CGAffineTransform(scaleX: 0.5, y: 0.5)
        octagon.setAffineTransform(scale)
    }
    
    @objc func moveOctagon() {
        octagon.removeAllAnimations()
        octagon.position = CGPoint(x: originalPosition.x + 100, y: originalPosition.y)
    }
    
    @objc func roundCorners() {
        octagon.removeAllAnimations()
        let circlePath = UIBezierPath(arcCenter: CGPoint.zero, radius: 50, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        octagon.path = circlePath.cgPath
    }
}
