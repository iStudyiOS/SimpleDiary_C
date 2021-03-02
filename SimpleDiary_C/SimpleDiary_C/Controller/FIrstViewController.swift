//
//  FIrstViewController.swift
//  SimpleDiary_C
//
//  Created by SEONGJIN CHO on 2021/02/27.
//

import UIKit

class FIrstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   
    @IBOutlet weak var mainName: UILabel!
    @IBOutlet weak var famousSaying: UIImageView!
    
    @IBAction func dailyButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "daily", message: "일간 일정을 작성합니다.", preferredStyle: UIAlertController.Style.alert)
        
        let moveToDaily = UIAlertAction(title: "이동", style: .default) { (action) in
            guard let second = self.tabBarController?.viewControllers?[1] else { return }
            self.tabBarController?.selectedViewController = second
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { (action) in
                   
        }
        
        alert.addAction(moveToDaily)
        alert.addAction(cancelAction)
       
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
    
    @IBAction func weekly(_ sender: Any) {
        
        
        let alert = UIAlertController(title: "weekly", message: "주간 일정을 작성합니다.", preferredStyle: UIAlertController.Style.alert)

        let moveToWeekly = UIAlertAction(title: "이동", style: .default) { (action) in
            guard let thrid = self.tabBarController?.viewControllers?[2] else { return }
            self.tabBarController?.selectedViewController = thrid
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { (action) in
                   
            }
        
        alert.addAction(cancelAction)
        alert.addAction(moveToWeekly)
        present(alert, animated: false, completion: nil)
    }
    
    
    @IBAction func monthly(_ sender: Any) {
        
        let alert = UIAlertController(title: "monthly", message: "월간 일정을 작성합니다.", preferredStyle: UIAlertController.Style.alert)
        
        
        
        let moveToMonthly = UIAlertAction(title: "이동", style: .default) { (action) in
            guard let forth = self.tabBarController?.viewControllers?[3] else { return }
            self.tabBarController?.selectedViewController = forth
            
            }

        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { (action) in
                   
            }
        
        alert.addAction(cancelAction)
        alert.addAction(moveToMonthly)
      
        present(alert, animated: false, completion: nil)
    }
    
    
    @IBAction func pomodoro(_ sender: Any) {
        
        let alert = UIAlertController(title: "pomodoro", message: "25분 공부하고 5분 휴식하는 공부법입니다.", preferredStyle: UIAlertController.Style.alert)
        
        
        let moveToPomodoro = UIAlertAction(title: "이동", style: .default) { (action) in
            let cancelalert = UIAlertController(title: "준비중", message: "포모도로 타이머 기능은 준비중입니다.", preferredStyle: UIAlertController.Style.alert)
            
            let cancelAction = UIAlertAction(title: "취소", style: .cancel)
            
            cancelalert.addAction(cancelAction)
            self.present(cancelalert, animated: true, completion: nil)
        }

    
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { (action) in
                   
        }
        
       
        alert.addAction(cancelAction)
        alert.addAction(moveToPomodoro)
        present(alert, animated: false, completion: nil)
        
        
    }
    
}



