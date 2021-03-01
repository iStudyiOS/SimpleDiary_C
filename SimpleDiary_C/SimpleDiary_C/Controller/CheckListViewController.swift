//
//  CheckListViewController.swift
//  SimpleDiary_C
//
//  Created by 홍경표 on 2021/02/27.
//

import UIKit

class CheckListViewController: UIViewController {
    
    static let identifier = String(describing: CheckListViewController.self)
    
    private enum State {
        case partial
        case full
    }
    
    private var fullViewPosition: CGFloat {
        return UIScreen.main.bounds.height - view.frame.height
    }
    private var partialViewPosition: CGFloat {
        UIScreen.main.bounds.height / 3 * 2
    }
    private let panGestureVelocityThreshold: CGFloat = 200
    var models: [String] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var colors: [String: UIColor] = [:]
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(UINib(nibName: CheckListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CheckListTableViewCell.identifier)
        setUpVC()
        setUpShortLine()
        setUpGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        shortenView()
    }
    
    // MARK: - Initialize
    
    private func setUpVC() {
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        view.layer.shadowColor = UIColor.label.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: -2)
        view.layer.shadowRadius = 5
    }
    
    private func setUpShortLine() {
        let lineWidth: CGFloat = 4
        let lineView = UIView()
        lineView.layer.cornerRadius = lineWidth / 2
        lineView.backgroundColor = .systemGray2
        self.view.addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 5),
            lineView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            lineView.widthAnchor.constraint(equalToConstant: 50),
            lineView.heightAnchor.constraint(equalToConstant: lineWidth)
        ])
    }
    
    private func setUpGesture() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture))
        view.addGestureRecognizer(gesture)
    }
    
    func shortenView() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseInOut) { [weak self] in
            guard let self = self else { return }
            self.moveView(state: .partial)
        }
    }
    
    private func moveView(state: State) {
        let yPosition = state == .partial ? partialViewPosition : fullViewPosition
        view.frame = CGRect(x: 0, y: yPosition, width: view.frame.width, height: view.frame.height)
    }
    
    private func moveView(panGestureRecognizer recognizer: UIPanGestureRecognizer) {
        let transition = recognizer.translation(in: view)
        let minY = view.frame.minY
        guard (minY + transition.y >= fullViewPosition) && (minY + transition.y <= partialViewPosition) else { return }
        view.frame = CGRect(x: 0, y: minY + transition.y, width: view.frame.width, height: view.frame.height)
        recognizer.setTranslation(CGPoint.zero, in: view)
    }
    
    @objc func panGesture(panGestureRecognizer recognizer: UIPanGestureRecognizer) {
        moveView(panGestureRecognizer: recognizer)
        guard recognizer.state == .ended else { return }
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseInOut) { [weak self] in
            guard let self = self else { return }
            let velocity = recognizer.velocity(in: self.view)
            let state: State
            if abs(velocity.y) > abs(velocity.x) && abs(velocity.y) > self.panGestureVelocityThreshold {
                state = velocity.y > 0 ? .partial : .full
            } else {
                state = self.view.frame.minY >= (self.fullViewPosition + self.partialViewPosition) / 2 ? .partial : .full
            }
            self.moveView(state: state)
        }
    }
    
}

extension CheckListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colors.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CheckListTableViewCell.identifier, for: indexPath) as? CheckListTableViewCell else {
            return UITableViewCell()
        }
        let str = colors.keys.sorted()[indexPath.row]
        cell.contentLabel.text = str
        cell.colorView.backgroundColor = colors[str]
        cell.accessoryType = models.contains(str) ? .checkmark : .none
        return cell
    }
    
}
