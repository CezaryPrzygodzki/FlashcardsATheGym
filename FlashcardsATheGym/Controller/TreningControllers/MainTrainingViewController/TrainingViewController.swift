//
//  TrainingViewController.swift
//  FlashcardsATheGym
//
//  Created by Cezary Przygodzki on 17/01/2021.
//

import UIKit

class TrainingViewController: UIViewController{

    private var topLabelStartTraining : UIView!
    private var previousTrainingsLabel: UILabel!
    private var previousTrainingsTableView: UITableView!
    let previousTrainingsTableViewCellIdentifier = "previousTrainingsTableViewCellIdentifier"
    
    private var trainingSummaryReportView : TrainingSummaryReportView!
    let blurView = UIButton()
    
    var previousTrainings: [Training] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
        configureNavigationAndTabBarControllers()
        
        topLabelStartTraining = configureTopLabelStartTraining()
        view.addSubview(topLabelStartTraining)
        
        previousTrainingsLabel = configurePreviousTrainingsLabel()
        view.addSubview(previousTrainingsLabel)
        
        configurePreviousTrainingsTableView()
        view.addSubview(previousTrainingsTableView)
        previousTrainingsTableView.topAnchor.constraint(equalTo: previousTrainingsLabel.bottomAnchor , constant: 25).isActive = true
        previousTrainingsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        previousTrainingsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        previousTrainingsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        configureBlurView()

        
        let traingingSummaryReportViewWidth = view.frame.size.width - 30
        trainingSummaryReportView = TrainingSummaryReportView(frame: CGRect(x: 15,
                                                                            y: view.frame.size.height/2 - traingingSummaryReportViewWidth/2,
                                                                            width: traingingSummaryReportViewWidth,
                                                                            height: traingingSummaryReportViewWidth))
        view.addSubview(trainingSummaryReportView)
        trainingSummaryReportView.isHidden = true
        trainingSummaryReportView.alpha = 0
        
        let currentWindow: UIWindow? = UIApplication.shared.keyWindow
        currentWindow?.addSubview(blurView)
        currentWindow?.addSubview(trainingSummaryReportView)
        
    }
    
    private func loadData(){
        let temporaryList : [Training] = DataHelper.shareInstance.loadData()
        previousTrainings = temporaryList.sorted(by: {
            $0.end?.compare($1.end!) == .orderedDescending
        })
        DispatchQueue.main.async {
            self.previousTrainingsTableView.reloadData()
        }
    }
    
    private func configureNavigationAndTabBarControllers(){

        self.tabBarController?.tabBar.tintColor = Colors.FATGpurple!
        title = "Trening"
        self.view.backgroundColor = Colors.FATGbackground
        navigationController?.setStatusBar(backgroundColor: Colors.FATGbackground!)
        navigationController?.navigationBar.backgroundColor = Colors.FATGbackground //large nav bar
        navigationController?.navigationBar.barTintColor = Colors.FATGbackground //small nav bar
        navigationController?.navigationBar.isTranslucent = false
        tabBarController?.tabBar.barTintColor = Colors.FATGBarTint
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Colors.FATGtext!]
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: Colors.FATGtext!]
    }

    private func configureTopLabelStartTraining() -> UIView{
        
        let topView = UIView()
        
        topView.backgroundColor = Colors.FATGpurple
        topView.frame.size.width = UIScreen.main.bounds.size.width - 50
        topView.frame.size.height = 250
        topView.frame = CGRect(x: UIScreen.main.bounds.size.width / 2 - topView.frame.size.width / 2,
                               y: UIScreen.main.bounds.size.width / 2 - topView.frame.size.width / 2,
                               width: topView.frame.size.width,
                               height: topView.frame.size.height)
        
        topView.layer.cornerRadius = 15
        
        let text = UILabel()
        text.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam eu quam quis eros ornare ornare. Pellentesque ut velit a neque ultricies egestas. "
        text.textColor = .white
        text.textAlignment = .center
        text.font = UIFont.systemFont(ofSize: 13, weight: .light)
        text.numberOfLines = 3
        
        text.frame.size.width = topView.frame.size.width - 30
        text.frame.size.height = 70
        text.frame = CGRect(x: topView.frame.size.width / 2 - text.frame.size.width / 2,
                            y: topView.frame.size.width / 2 - text.frame.size.width / 2,
                            width: text.frame.size.width,
                            height: text.frame.size.height)
        topView.addSubview(text)
        
        let image = UIImage(named: "trening")
        let imageView = UIImageView(image: image)
        let size :CGFloat = 260
        imageView.frame.size.width = size
        imageView.frame.size.height = size
        imageView.frame = CGRect(x: -45,
                                 y: text.bounds.maxY - 10 ,
                                 width: imageView.frame.size.width,
                                 height: imageView.frame.size.height)

        topView.addSubview(imageView)
        
        let button = UIButton()
        button.setTitle("Rozpocznij", for: .normal)
        button.setTitleColor(Colors.FATGpurple, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(start), for: .touchUpInside)
        
        button.frame.size.width = 100
        button.frame.size.height = 40
        button.frame = CGRect(x: topView.bounds.maxX - button.frame.size.width - 10,
                              y: topView.bounds.maxY - button.frame.size.height - 10,
                              width: button.frame.size.width,
                              height: button.frame.size.height)
        topView.addSubview(button)
        
        return topView
    }
    
    @objc private func start(){
        let chooseVC = SelectTrainigModeViewController()
        chooseVC.trainingViewController = self
        
        previousTrainingsTableView.resignFirstResponder()
        
        navigationController?.showDetailViewController(chooseVC, sender: true)
        
    }
    
    private func configurePreviousTrainingsLabel() -> UILabel {
        let label = UILabel()
        
        label.text = "Poprzednie treningi"
        label.textColor = Colors.FATGtext
        label.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        
        label.frame = CGRect(x: 25, y: topLabelStartTraining.bounds.maxY + 70, width: UIScreen.main.bounds.size.width - 50, height: 50)
        return label
    }
    
    private func configurePreviousTrainingsTableView() {
        previousTrainingsTableView = UITableView()
        //set row height
        previousTrainingsTableView.rowHeight = 130
        //register cells
        previousTrainingsTableView.register(PreviousTrainingsTableViewCell.self, forCellReuseIdentifier: previousTrainingsTableViewCellIdentifier)
        //set contraits
        previousTrainingsTableView.translatesAutoresizingMaskIntoConstraints = false
        //set delegates
        setPreviousTrainingsTableView()
        
        previousTrainingsTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        previousTrainingsTableView.showsVerticalScrollIndicator = false
                
        previousTrainingsTableView.backgroundColor = .clear
        
    }
    func comeBackFromSelectTraningModeAndPushTrennigSessionViewController(teacher: Teacher, selectedMode: SelectTrainigModeViewController.TypeOfTraining, duration: Double){
        
        let sessionVC = TrainingSessionViewController()
        sessionVC.modalPresentationStyle = .fullScreen
        sessionVC.teacher = teacher
        sessionVC.typeOfTraining = selectedMode
        sessionVC.durationOfCountingDownTimer = duration
        sessionVC.trainingViewController = self
        
        
        navigationController?.showDetailViewController(sessionVC, sender: true)
    }
    
    func comeBackFromTrainingSessionViewControllerAndPushTrainingSummaryReport(training: Training){
        loadData()
        trainingSummaryReportView.configureLabelsText(training: training)
        
    }
    
    private func configureBlurView() {
        blurView.frame = UIApplication.shared.keyWindow!.frame
        UIApplication.shared.keyWindow!.addSubview(blurView)
        blurView.backgroundColor = .gray
        blurView.isHidden = true
        blurView.alpha = 0
        
        blurView.addTarget(self, action: #selector(hideBlurAndTrainingSummaryReportView), for: .touchUpInside)
        view.addSubview(blurView)
    }
    
    @objc private func hideBlurAndTrainingSummaryReportView(){
        UIView.animate(withDuration: 1) {
            self.blurView.alpha = 0
            self.trainingSummaryReportView.alpha = 0
        } completion: { _ in
            self.blurView.isHidden = true
            self.trainingSummaryReportView.isHidden = true
        }
    }
    func showBlur(){
        self.blurView.isHidden = false
        UIView.animate(withDuration: 1) {
            self.blurView.alpha = 0.4
        }
    }
    
    func showTrainingSummaryReportView(){
        self.trainingSummaryReportView.isHidden = false
        UIView.animate(withDuration: 1) {
            self.trainingSummaryReportView.alpha = 1
        }
    }
    
}



extension TrainingViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        previousTrainings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: previousTrainingsTableViewCellIdentifier, for: indexPath) as? PreviousTrainingsTableViewCell else {
            fatalError("Bad Instance")
        }
    
        let prevTraining = previousTrainings[indexPath.row]
        
        cell.configureRow(training: prevTraining)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? PreviousTrainingsTableViewCell else {
            fatalError("Bad Instance")
        }
        cell.selectionStyle = .none
        let training = previousTrainings[indexPath.row]
        trainingSummaryReportView.configureLabelsText(training: training)
        showBlur()
        showTrainingSummaryReportView()
    }
    
    private func  setPreviousTrainingsTableView() {
        previousTrainingsTableView.delegate = self
        previousTrainingsTableView.dataSource = self
        
    }
    
}

