//
//  SelectTrainigModeViewController.swift
//  FlashcardsATheGym
//
//  Created by Cezary Przygodzki on 02/05/2021.
//

import UIKit

class SelectTrainigModeViewController: UIViewController {

    enum TypeOfTraining {
        case strength
        case cardio
        case empty
    }
    private var chosenTypeOfTraining: TypeOfTraining = .empty
    private var heightOfScrollView: CGFloat = 0
    private let padding: CGFloat = 20
    private let lessonTableViewCellIndentifier = "lessonTableViewCellIndentifier"
    private let lessons: [Lesson] = {
        return DataHelper.shareInstance.loadData()
    }()
    private var chosenLesson: Lesson?
    var trainingViewController: TrainingViewController? = nil
    
    private let littleBarView = UIView()
    
    private let scrollView = UIScrollView()
    private let conteinerView = UIView()
    
    private let selectTraningModeLabel = UILabel()
    
    private let strengthTraningButton = UIButton()
    private let cardioTrainingButton = UIButton()
    private let horizontalStackView = UIStackView()
    
    private let selectDurationOfTraningLabel = UILabel()
    private let datePicker = UIDatePicker() 
    
    private var topAnchorOfLabelChooseLessonTOP: NSLayoutConstraint?
    private var topAnchorOfLabelChooseLessonBOTTOM: NSLayoutConstraint?
    private let chooseLessonLabel = UILabel()
    private let lessonsTableView = UITableView()
    
    private let startTraningButton = UIButton()
    private let labelError = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.FATGbackground
        
        configureLittleBarView()
        view.addSubview(littleBarView)
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: 2000)

        scrollView.addSubview(conteinerView)
        conteinerView.frame.size = CGSize(width: view.frame.size.width, height: 2000)
        
        conteinerView.addSubview(selectTraningModeLabel)
        createSelectTraningModeLabel()
        
        conteinerView.addSubview(horizontalStackView)
        configureTrainingButtons()
        
        conteinerView.addSubview(chooseLessonLabel)
        configureChooseLessonLabel()
        
        conteinerView.addSubview(lessonsTableView)
        configureLessonsTableView()
        
        conteinerView.addSubview(startTraningButton)
        startTrainingButton()
        
        conteinerView.addSubview(labelError)
        configureLabelError()
        labelError.alpha = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: heightOfScrollView)
        conteinerView.frame.size = CGSize(width: view.frame.size.width, height: heightOfScrollView)
    }
    
    private func configureLittleBarView(){
        littleBarView.backgroundColor = .lightGray
        littleBarView.layer.cornerRadius = 5
        littleBarView.frame.size.width = 100
        littleBarView.frame = CGRect(x: self.view.frame.size.width / 2 - littleBarView.frame.size.width / 2,
                                     y: 10,
                                     width: littleBarView.frame.size.width,
                                     height: 5)
    }
    

    private func createSelectTraningModeLabel(){
        selectTraningModeLabel.text = "Wybierz tryb"
        selectTraningModeLabel.textColor = Colors.FATGtext
        selectTraningModeLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        selectTraningModeLabel.translatesAutoresizingMaskIntoConstraints = false
        selectTraningModeLabel.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: padding).isActive = true
        selectTraningModeLabel.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: padding).isActive = true
        selectTraningModeLabel.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -padding).isActive = true
        
        self.heightOfScrollView += 45
    }
    
    private func configureTrainingButtons(){
        strengthTraningButton.setTitle("Trening siłowy", for: .normal)
        strengthTraningButton.setTitleColor(Colors.FATGtext, for: .normal)
        strengthTraningButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        strengthTraningButton.layer.cornerRadius = 10
        strengthTraningButton.addTarget(self, action: #selector(strengthPressed), for: .touchUpInside)
        
        cardioTrainingButton.setTitle("Trening cardio", for: .normal)
        cardioTrainingButton.setTitleColor(Colors.FATGtext, for: .normal)
        cardioTrainingButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        cardioTrainingButton.layer.cornerRadius = 10
        cardioTrainingButton.addTarget(self, action: #selector(cardioPressed), for: .touchUpInside)

        configureBackgrodundColorOfButtons()
        
        horizontalStackView.addArrangedSubview(strengthTraningButton)
        horizontalStackView.addArrangedSubview(cardioTrainingButton)
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.spacing = padding
        
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.topAnchor.constraint(equalTo: selectTraningModeLabel.bottomAnchor, constant: padding).isActive = true
        horizontalStackView.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: padding).isActive = true
        horizontalStackView.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -padding).isActive = true
        horizontalStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.heightOfScrollView += 120
    }
    
    @objc private func strengthPressed(sender: UIButton!){
        chosenTypeOfTraining = chosenTypeOfTraining == .strength ? .empty : .strength
        configureBackgrodundColorOfButtons()
    }
    
    @objc private func cardioPressed(sender: UIButton!){
        chosenTypeOfTraining = chosenTypeOfTraining == .cardio ? .empty : .cardio
        configureBackgrodundColorOfButtons()
    }
    private func addDurationOfTraningToViewWithAnimation(){
        conteinerView.addSubview(selectDurationOfTraningLabel)
        configureSelectDurationOfTraningLabel()
    
        conteinerView.addSubview(datePicker)
        configureDatePicker()
        UIView.animate(withDuration: 0.3) { [self] in
            // 2 lines below mean that label and datePicker are fading in
            selectDurationOfTraningLabel.alpha = 1
            datePicker.alpha = 1
            
            //I'm changing which constraints are active, then I call layoutIfNeeded() func to make the User see animation
            topAnchorOfLabelChooseLessonTOP?.isActive = false
            topAnchorOfLabelChooseLessonBOTTOM?.isActive = true
            self.view.layoutIfNeeded()
        } completion: { completed in
            //aditional code here
        }
    }
    private func removeDurationOfTraningFromViewWithAnimation(){
        UIView.animate(withDuration: 0.3) { [self] in
            //2 lines below mean that label and datePicker are fading away
            selectDurationOfTraningLabel.alpha = 0
            datePicker.alpha = 0
            //I'm changing which constraints are active, then I call layoutIfNeeded() func to make the User see animation
            topAnchorOfLabelChooseLessonBOTTOM?.isActive = false
            topAnchorOfLabelChooseLessonTOP?.isActive = true
            self.view.layoutIfNeeded()
        } completion: { [self] completed in
            selectDurationOfTraningLabel.removeFromSuperview()
            datePicker.removeFromSuperview()
        }
    }
    
    private func configureBackgrodundColorOfButtons(){
        switch chosenTypeOfTraining {
        case .cardio:
            
            cardioTrainingButton.backgroundColor = Colors.FATGpurple
            strengthTraningButton.backgroundColor = Colors.FATGWhiteBlack
            addDurationOfTraningToViewWithAnimation()
        case .strength:
            strengthTraningButton.backgroundColor = Colors.FATGpink
            cardioTrainingButton.backgroundColor = Colors.FATGWhiteBlack
            removeDurationOfTraningFromViewWithAnimation()
        case .empty:
            cardioTrainingButton.backgroundColor = Colors.FATGWhiteBlack
            strengthTraningButton.backgroundColor = Colors.FATGWhiteBlack
            removeDurationOfTraningFromViewWithAnimation()
        }
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: heightOfScrollView)
        conteinerView.frame.size = CGSize(width: view.frame.size.width, height: heightOfScrollView)
    }
    
    private func configureSelectDurationOfTraningLabel(){
        selectDurationOfTraningLabel.text = "Wybierz czas trwania treningu"
        selectDurationOfTraningLabel.textColor = Colors.FATGtext
        selectDurationOfTraningLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        
        selectDurationOfTraningLabel.translatesAutoresizingMaskIntoConstraints = false
        selectDurationOfTraningLabel.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: padding).isActive = true
        selectDurationOfTraningLabel.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: padding).isActive = true
        selectDurationOfTraningLabel.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -padding).isActive = true
        //selectTraningModeLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true

        selectDurationOfTraningLabel.alpha = 0
        self.heightOfScrollView += 45
    }
    private func configureDatePicker(){
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .countDownTimer
        
        datePicker.setValue(Colors.FATGpurple, forKey: "textColor")
        datePicker.tintColor = .red
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.topAnchor.constraint(equalTo: selectDurationOfTraningLabel.bottomAnchor, constant: 0).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: padding).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -padding).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        datePicker.alpha = 0
        self.heightOfScrollView += 140
    }
    
    private func configureChooseLessonLabel(){
        chooseLessonLabel.text = "Wybierz lekcję"
        chooseLessonLabel.textColor = Colors.FATGtext
        chooseLessonLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        chooseLessonLabel.translatesAutoresizingMaskIntoConstraints = false
        topAnchorOfLabelChooseLessonTOP = chooseLessonLabel.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: padding)
        topAnchorOfLabelChooseLessonTOP?.isActive = true
        topAnchorOfLabelChooseLessonBOTTOM = chooseLessonLabel.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: padding)
        topAnchorOfLabelChooseLessonBOTTOM?.isActive = false
        chooseLessonLabel.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: padding).isActive = true
        chooseLessonLabel.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -padding).isActive = true
        
        self.heightOfScrollView += 45
    }
    
    private func configureLessonsTableView(){
        let rowHeight : CGFloat = 50
        let tableViewHeight = CGFloat(lessons.count) * rowHeight
        lessonsTableView.rowHeight = rowHeight
        lessonsTableView.register(LessonsTableViewCell.self, forCellReuseIdentifier: lessonTableViewCellIndentifier)
        setLessonsTableViewDelegates()
        lessonsTableView.backgroundColor = .clear
        lessonsTableView.showsVerticalScrollIndicator = false
        lessonsTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        lessonsTableView.isScrollEnabled = false
        
        lessonsTableView.translatesAutoresizingMaskIntoConstraints = false
        lessonsTableView.topAnchor.constraint(equalTo: chooseLessonLabel.bottomAnchor, constant: padding).isActive = true
        lessonsTableView.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: padding).isActive = true
        lessonsTableView.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -padding).isActive = true
        lessonsTableView.heightAnchor.constraint(equalToConstant: tableViewHeight).isActive = true
        
        self.heightOfScrollView += tableViewHeight
    }
    private func startTrainingButton(){
        startTraningButton.setTitle("Rozpocznij trening", for: .normal)
        startTraningButton.setTitleColor(Colors.FATGtext, for: .normal)
        startTraningButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        startTraningButton.layer.cornerRadius = 10
        startTraningButton.backgroundColor = Colors.FATGWhiteBlack
        
        
        startTraningButton.translatesAutoresizingMaskIntoConstraints = false
        startTraningButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        startTraningButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        startTraningButton.centerXAnchor.constraint(equalTo: conteinerView.centerXAnchor).isActive = true
        startTraningButton.topAnchor.constraint(equalTo: lessonsTableView.bottomAnchor, constant: padding).isActive = true
        
        self.heightOfScrollView += 50 + padding
        
        startTraningButton.addTarget(self, action: #selector(startTraining), for: .touchUpInside)
    }
    
    @objc private func startTraining(){
        let flashcardsToSend : [Flashcard] = (self.chosenLesson == nil) ? (DataHelper.shareInstance.loadData()) : (DataHelper.shareInstance.loadFlashcards(lesson: self.chosenLesson!))


        let duration = datePicker.countDownDuration

            if flashcardsToSend.count != 0 {
                if chosenTypeOfTraining == .empty {
                    showError("Wybierz rodzaj treningu")
                    return
                }
                dismiss(animated: true) {
                let teacher = Teacher(lesson: self.chosenLesson, flashcards: flashcardsToSend)
                    self.trainingViewController?.comeBackFromSelectTraningModeAndPushTrennigSessionViewController(teacher: teacher, selectedMode: self.chosenTypeOfTraining, duration: duration)
                }
            } else {
                showError("Lista jest pusta, wybierz inną")
            }
            
        
    }
    
    private func configureLabelError() {
        labelError.error()
        labelError.frame = CGRect(x: self.view.frame.size.width/2 - labelError.frame.size.width/2,
                                  y: startTraningButton.frame.origin.y + startTraningButton.frame.size.height + 20,
                                  width: labelError.frame.size.width,
                                  height: labelError.frame.size.height)
        labelError.sizeToFit()
        labelError.frame.size.width = self.view.frame.size.width - 50
        //I set the maximum dimensions first, then call sizeToFit() to reduce my height, and finally I set the width again.
        
    }
    private func showError(_ message:String){
        
        configureLabelError()
        labelError.text = message
        labelError.alpha = 1
    }
    
}


extension SelectTrainigModeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lessons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: lessonTableViewCellIndentifier, for: indexPath) as? LessonsTableViewCell else {
            fatalError("Bad instance")
        }
        
        let lesson = lessons[indexPath.row]
        cell.nameOfListOfFlashcardsLabel.text = lesson.name
        
        if self.chosenLesson != lesson {
            cell.checkButton.setOn(false, animated: true)
        }
        cell.checkButtonPressed = {
            if self.chosenLesson != lesson {
                self.chosenLesson = lesson
            } else if self.chosenLesson == lesson {
                self.chosenLesson = nil
            }
            self.lessonsTableView.reloadData()
        }

        return cell
    }
    
    private func setLessonsTableViewDelegates(){
        lessonsTableView.delegate = self
        lessonsTableView.dataSource = self
    }
}
