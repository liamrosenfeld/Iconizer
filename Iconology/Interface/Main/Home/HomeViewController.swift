//
//  DragViewController.swift
//  Iconology
//
//  Created by Liam Rosenfeld on 2/1/18.
//  Copyright © 2018 Liam Rosenfeld. All rights reserved.
//

import AppKit

class HomeViewController: NSViewController {
    
    @IBOutlet weak var dragView: DragView!
    @IBOutlet weak var imageView: NSImageView!
    @IBOutlet weak var descriptionLabel: NSTextField!
    @IBOutlet weak var subText: NSTextField!
    
    
    var imageURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dragView.delegate = self
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func toOptionsVC() {
        let optionsViewController = storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("OptionsViewController")) as? OptionsViewController
        optionsViewController?.imageURL = imageURL!
        view.window?.contentViewController = optionsViewController
    }
    
    @IBAction func chooseFileClicked(_ sender: Any) {
        guard let url = FileHandler.chooseFile() else {
            return
        }
        imageURL = url
        toOptionsVC()
    }
}

extension HomeViewController: DragViewDelegate {
    
    func dragViewDidHover() {
        self.descriptionLabel.stringValue = "That would work!"
        self.subText.stringValue = ""
    }
    
    func dragViewMouseExited(){
        self.descriptionLabel.stringValue = "Drag and Drop an Image File Here"
        self.subText.stringValue = "(Input a High-Resolution Image)"
    }
    
    func dragView(didDragFileWith url: URL) {
        imageURL = url
        print(url)
        toOptionsVC()
    }
    
}
