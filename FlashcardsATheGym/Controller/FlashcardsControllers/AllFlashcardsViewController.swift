//
//  AllFlashcardsViewController.swift
//  FlashcardsATheGym
//
//  Created by Cezary Przygodzki on 20/01/2021.
//

import UIKit

class AllFlashcardsViewController: UIViewController {

    var flashcards: [Flashcard] = []//List of loaded flashcards
    var flashcardToEdit: Flashcard?
    
    private let imageViewAddbutton = UIImageView()
    
    var flashcardsTableView: UITableView!
    private let flashcardsTableViewCellIdentifier = "flashcardsTableViewCellIdentifier"

    private var thereIsCellTapped = false
    private var selectedRowIndex = -1
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Wszystkie fiszki"
        view.backgroundColor = Colors.FATGbackground
        navigationController?.navigationBar.tintColor = Colors.FATGpurple
        
        createAddButton()
        loadData()
        
        configureFlashcardsTableView()
        view.addSubview(flashcardsTableView)
        flashcardsTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 25 ).isActive = true
        flashcardsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        flashcardsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        flashcardsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive       = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        imageViewAddbutton.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        imageViewAddbutton.isHidden = false
    }
    
    private func createAddButton(){
        imageViewAddbutton.image = UIImage(systemName: "plus.circle.fill")
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addButtonAction))
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        
        navigationBar.addSubview(imageViewAddbutton)
        imageViewAddbutton.clipsToBounds = true
        imageViewAddbutton.translatesAutoresizingMaskIntoConstraints = false
        imageViewAddbutton.isUserInteractionEnabled = true
        imageViewAddbutton.addGestureRecognizer(tapGestureRecognizer)

        imageViewAddbutton.tintColor = Colors.FATGpink
        NSLayoutConstraint.activate([
            imageViewAddbutton.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -16),
            imageViewAddbutton.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -12),
            imageViewAddbutton.heightAnchor.constraint(equalToConstant: 45),
            imageViewAddbutton.widthAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    @objc func addButtonAction() {
        
        let addVC = UIStoryboard(name: "Main",
                                 bundle: nil)
            .instantiateViewController(identifier: "addFlashcard") as! AddFlashcardsViewController
    
        addVC.allFlashcardsViewController = self

      
        self.navigationController?.showDetailViewController(addVC, sender: true)

    }

    func loadData(){
        
        flashcards = DataHelper.shareInstance.loadData()
        
        DispatchQueue.main.async {
            self.flashcardsTableView.reloadData()
        }
        
    }
    private func configureFlashcardsTableView(){
        
        flashcardsTableView = UITableView()
        flashcardsTableView.register(FlashcardsTableViewCell.self, forCellReuseIdentifier: flashcardsTableViewCellIdentifier)
        flashcardsTableView.translatesAutoresizingMaskIntoConstraints = false
        setFlashcardsTableViewDelegates()
        
        flashcardsTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        flashcardsTableView.showsVerticalScrollIndicator = false
        flashcardsTableView.backgroundColor = .clear

    }
    
    func backFromAddingNewFlashcard( data: Flashcard!){
        flashcards.append(data)
        flashcardsTableView.reloadData()
    }

}


extension AllFlashcardsViewController:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flashcards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: flashcardsTableViewCellIdentifier, for: indexPath) as? FlashcardsTableViewCell else {
            fatalError("Bad Instance")
        }
        cell.selectionStyle = .none
        let flashcard = flashcards[indexPath.row]
        cell.wordLabel.text = flashcard.word
        cell.translationLabel.text = flashcard.translation
        cell.pronunciationLabel.text = "wym. /\(flashcard.pronunciation ?? "  ")/"
        cell.meaningLabel.text = flashcard.meaning
        cell.exampleLabel.text = flashcard.example
        
       
        cell.animate()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if selectedRowIndex != indexPath.row {
               self.thereIsCellTapped = true
               self.selectedRowIndex = indexPath.row
            
           }
           else {
               // there is no cell selected anymore
               self.thereIsCellTapped = false
               self.selectedRowIndex = -1
           }

        tableView.beginUpdates()
        tableView.reloadRows(at: [indexPath], with: .none)
        tableView.endUpdates()

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let flashcard = flashcards[indexPath.row]
        
        if indexPath.row == selectedRowIndex && thereIsCellTapped {
            var height:  CGFloat = 190
            
            height = ( flashcard.meaning == "" ) ? ( height - 18 ) : ( height + CGFloat(( 18 * ( flashcard.meaning!.count / 38 ) )))
            height = ( flashcard.example == "" ) ? ( height - 18 ) : ( height + CGFloat(( 18 * ( flashcard.example!.count / 38 ) )))
        
            return height
        }
        return 90
    }

    private func setFlashcardsTableViewDelegates(){
        flashcardsTableView.delegate = self
        flashcardsTableView.dataSource = self
    }


    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "Usuń") { [self] (action, view, completion) in
        
            let flashcard = flashcards[indexPath.row]
            DataHelper.shareInstance.deleteData(object: flashcard)
        
            flashcards.remove(at: indexPath.row)
            flashcardsTableView.deleteRows(at: [indexPath], with: .fade)
        
          completion(true)
      }

        let muteAction = UIContextualAction(style: .normal, title: "Edytuj") { [self] (action, view, completion) in

        let editFlashcards = UIStoryboard(name: "Main",
                                 bundle: nil)
            .instantiateViewController(identifier: "editFlashcard") as! EditFlashcardsViewController
        
        flashcardToEdit = self.flashcards[indexPath.row]

        editFlashcards.allFlashcardsViewController = self
        editFlashcards.flashcardToEdit = self.flashcardToEdit

        self.navigationController?.showDetailViewController(editFlashcards, sender: true)


        completion(true)
      }
        muteAction.backgroundColor = Colors.FATGpurple
        deleteAction.backgroundColor = Colors.FATGpink
      return UISwipeActionsConfiguration(actions: [deleteAction, muteAction])
    }
    
   
    
    
}
