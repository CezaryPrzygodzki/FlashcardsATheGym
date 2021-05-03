//
//  AddFlashcardsViewController.swift
//  FlashcardsATheGym
//
//  Created by Cezary Przygodzki on 20/01/2021.
//

import UIKit

class AddFlashcardsViewController: UIViewController {

    private var heightOfScrollView: CGFloat = 0
    private let padding: CGFloat = 10
    private let lessonTableViewCellIndentifier = "lessonTableViewCellIndentifier"
    
    private let littleBarView = UIView()
    let titleLabel = UILabel()
    
    private let scrollView = UIScrollView()
    private let conteinerView = UIView()
    
    private let labelWord = UILabel()
    let textFieldWord = UITextField()
    
    private let labelTranslation = UILabel()
    let textFieldTranslation = UITextField()
    
    private let labelPronunciation = UILabel()
    let textFieldPronunciation = UITextField()
    
    private let labelMeaning = UILabel()
    let textFieldMeaning = UITextField()
    
    private let labelExample = UILabel()
    let textFieldExample = UITextField()
    
    let addButton = UIButton()
    private var lessonsTableView = UITableView()
    private let saveInLabel = UILabel()
    
    var flashcardsViewController: FlashcardsViewController?
    var allFlashcardsViewController: AllFlashcardsViewController?

    private let lessons: [Lesson] = {
    return DataHelper.shareInstance.loadData()
}()
    var saveThisFlashcardInLessons : [Lesson] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.FATGbackground
        title = "Nowa fiszka"
        
        configureLittleBarView()
        view.addSubview(littleBarView)
               
        configureTitleLabel()
        view.addSubview(titleLabel)
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: 2000)

        scrollView.addSubview(conteinerView)
        conteinerView.frame.size = CGSize(width: view.frame.size.width, height: 2000)
        
        conteinerView.addSubview(labelWord)
        createLabelWord()
        conteinerView.addSubview(textFieldWord)
        createTextFieldWord()
        
        conteinerView.addSubview(labelTranslation)
        createLabelTranslation()
        conteinerView.addSubview(textFieldTranslation)
        createTextFieldTranslation()

        conteinerView.addSubview(labelPronunciation)
        createLabelPronunciation()
        conteinerView.addSubview(textFieldPronunciation)
        createTextFieldPronunciation()

        conteinerView.addSubview(labelMeaning)
        createLabelMeaning()
        conteinerView.addSubview(textFieldMeaning)
        createTextFieldMeaning()

        conteinerView.addSubview(labelExample)
        createLabelExample()
        conteinerView.addSubview(textFieldExample)
        createTextFieldExample()

        conteinerView.addSubview(saveInLabel)
        configureSaveInLabel()

        conteinerView.addSubview(lessonsTableView)
        configureLessonsTableView()

        conteinerView.addSubview(addButton)
        createAddButton()
        
        print("Height of scroll view = \(heightOfScrollView)")
        print("Height of view = \(view.frame.size.height)")

        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    
        
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
    private func configureTitleLabel(){
        
        titleLabel.text = "Nowa fiszka"
        titleLabel.textColor = Colors.FATGtext
        titleLabel.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        titleLabel.frame = CGRect(x: 25, y: 40, width: 400, height: 100)
        titleLabel.sizeToFit()

        
    }
    private func createLabelWord(){
        labelWord.newFlashcardLabel(text: "Wyraz")
        labelWord.translatesAutoresizingMaskIntoConstraints = false
        labelWord.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 10).isActive = true
        labelWord.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 20).isActive = true
        labelWord.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -5).isActive = true
        labelWord.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.heightOfScrollView += 30
    }
    private func createTextFieldWord(){
        textFieldWord.textField(placeholder: "sensational")
        textFieldWord.translatesAutoresizingMaskIntoConstraints = false
        textFieldWord.topAnchor.constraint(equalTo: labelWord.bottomAnchor, constant: 5).isActive = true
        textFieldWord.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 20).isActive = true
        textFieldWord.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -20).isActive = true
        textFieldWord.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.heightOfScrollView += 45
    }
    
    
    private func createLabelTranslation(){
        labelTranslation.newFlashcardLabel(text: "Tłumaczenie")
        labelTranslation.translatesAutoresizingMaskIntoConstraints = false
        labelTranslation.topAnchor.constraint(equalTo: textFieldWord.bottomAnchor, constant: 10).isActive = true
        labelTranslation.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 20).isActive = true
        labelTranslation.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -5).isActive = true
        labelTranslation.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.heightOfScrollView += 30
    }
    
    private func createTextFieldTranslation(){
        textFieldTranslation.textField(placeholder: "rewelacyjny")
        textFieldTranslation.translatesAutoresizingMaskIntoConstraints = false
        textFieldTranslation.topAnchor.constraint(equalTo: labelTranslation.bottomAnchor, constant: 5).isActive = true
        textFieldTranslation.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 20).isActive = true
        textFieldTranslation.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -20).isActive = true
        textFieldTranslation.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.heightOfScrollView += 45
    }
    
    
    private func createLabelPronunciation(){
        labelPronunciation.newFlashcardLabel(text: "Wymowa")
        labelPronunciation.translatesAutoresizingMaskIntoConstraints = false
        labelPronunciation.topAnchor.constraint(equalTo: textFieldTranslation.bottomAnchor, constant: 10).isActive = true
        labelPronunciation.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 20).isActive = true
        labelPronunciation.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -5).isActive = true
        labelPronunciation.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.heightOfScrollView += 30
    }
    
    private func createTextFieldPronunciation(){
        textFieldPronunciation.textField(placeholder: "sensejszynal")
        textFieldPronunciation.translatesAutoresizingMaskIntoConstraints = false
        textFieldPronunciation.topAnchor.constraint(equalTo: labelPronunciation.bottomAnchor, constant: 5).isActive = true
        textFieldPronunciation.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 20).isActive = true
        textFieldPronunciation.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -20).isActive = true
        textFieldPronunciation.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.heightOfScrollView += 45
    }
    
    
    private func createLabelMeaning(){
        labelMeaning.newFlashcardLabel(text: "Znaczenie")
        labelMeaning.translatesAutoresizingMaskIntoConstraints = false
        labelMeaning.topAnchor.constraint(equalTo: textFieldPronunciation.bottomAnchor, constant: 10).isActive = true
        labelMeaning.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 20).isActive = true
        labelMeaning.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -5).isActive = true
        labelMeaning.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.heightOfScrollView += 30
    }
    private func createTextFieldMeaning(){
        textFieldMeaning.textField(placeholder: "very good, exciting")
        textFieldMeaning.translatesAutoresizingMaskIntoConstraints = false
        textFieldMeaning.topAnchor.constraint(equalTo: labelMeaning.bottomAnchor, constant: 5).isActive = true
        textFieldMeaning.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 20).isActive = true
        textFieldMeaning.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -20).isActive = true
        textFieldMeaning.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.heightOfScrollView += 45
    }
    
    
    private func createLabelExample(){
        labelExample.newFlashcardLabel(text: "Użycie")
        labelExample.translatesAutoresizingMaskIntoConstraints = false
        labelExample.topAnchor.constraint(equalTo: textFieldMeaning.bottomAnchor, constant: 10).isActive = true
        labelExample.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 20).isActive = true
        labelExample.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -5).isActive = true
        labelExample.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.heightOfScrollView += 30
    }
    private func createTextFieldExample(){
        textFieldExample.textField(placeholder: "You look sensational this evening!")
        textFieldExample.translatesAutoresizingMaskIntoConstraints = false
        textFieldExample.topAnchor.constraint(equalTo: labelExample.bottomAnchor, constant: 5).isActive = true
        textFieldExample.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 20).isActive = true
        textFieldExample.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -20).isActive = true
        textFieldExample.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.heightOfScrollView += 45
    }
    
    
    private func configureSaveInLabel() {
        saveInLabel.text = "Zapisz tę fiszkę w lekcji:"
        saveInLabel.textColor = Colors.FATGtext
        saveInLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)

        saveInLabel.translatesAutoresizingMaskIntoConstraints = false
        saveInLabel.topAnchor.constraint(equalTo: textFieldExample.bottomAnchor, constant: 20).isActive = true
        saveInLabel.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 20).isActive = true
        saveInLabel.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -5).isActive = true
        saveInLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
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
        lessonsTableView.topAnchor.constraint(equalTo: saveInLabel.bottomAnchor, constant: 10).isActive = true
        lessonsTableView.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 20).isActive = true
        lessonsTableView.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -20).isActive = true
        lessonsTableView.heightAnchor.constraint(equalToConstant: tableViewHeight).isActive = true
        
        self.heightOfScrollView += tableViewHeight
    }
    

    private func createAddButton() {
        addButton.setTitle("Dodaj", for: UIControl.State.normal)
        addButton.setTitleColor(Colors.FATGWhiteBlack, for: .normal)
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .semibold)
        addButton.backgroundColor = Colors.FATGtext
        addButton.layer.cornerRadius = 10
        
        addButton.addTarget(self, action: #selector(addButtonFunc), for: .touchUpInside)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        addButton.topAnchor.constraint(equalTo: lessonsTableView.bottomAnchor, constant: 20).isActive = true
        addButton.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: self.view.frame.size.width / 2 - 50).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.heightOfScrollView += 100
    
    }
    
    @objc func addButtonFunc(sender: UIButton!){
        
        print("Przycisk do dodawania")
        
        let word = textFieldWord.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let translation = textFieldTranslation.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let pronunciation = textFieldPronunciation.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let meaning = textFieldMeaning.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let example = textFieldExample.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if ( word == "" ){
            Alert.wrongData(on: self, message: "Uzupełnij pole wyraz.")
        } else if ( translation == "" ){
            Alert.wrongData(on: self, message: "Uzupełnij pole tłumaczenie.")
        } else if ( word == "" ) && ( translation == "" ) {
            Alert.wrongData(on: self, message: "Uzupełnij pola nazwa oraz tłumaczenie.")
        } else {
            
            let flashcard = DataHelper.shareInstance.saveData(word: word, translation: translation, pronunciation: pronunciation, meaning: meaning, example: example, lessons: saveThisFlashcardInLessons)
            allFlashcardsViewController?.backFromAddingNewFlashcard(data: flashcard)
            var lists : [Lesson] = []
            lists = flashcard.lesson?.allObjects as! [Lesson]
            for list in lists {
                print(list.name)
            }
            print("Ta fiszka jest w: \(flashcard.lesson?.count) lekcjach")
            }
            
        
        dismiss(animated: true, completion: nil)
    }
        
}

extension AddFlashcardsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lessons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: lessonTableViewCellIndentifier, for: indexPath) as? LessonsTableViewCell else {
            fatalError("Bad instance")
        }
        
        let lesson = lessons[indexPath.row]
        cell.nameOfListOfFlashcardsLabel.text = lesson.name
        
        if self.saveThisFlashcardInLessons.contains(lesson) {
            cell.checkButton.setOn(true, animated: true)
        }
        
        cell.checkButtonPressed = {
            if !self.saveThisFlashcardInLessons.contains(lesson) {
                self.saveThisFlashcardInLessons += [lesson]
            } else {
                if let index = self.saveThisFlashcardInLessons.firstIndex(of: lesson) { //sprawdza czy jest dany index, jak znajdzie to zwraca nam jego pozycję
                    self.saveThisFlashcardInLessons.remove(at: index) //wejdziemy do środka i utworzymy zmienną tylko, jeżeli obiekt jest w tej liście
                }
            }
        }
        return cell
    }
    
    
    func setLessonsTableViewDelegates(){
        lessonsTableView.delegate = self
        lessonsTableView.dataSource = self
    }
    
}
    

