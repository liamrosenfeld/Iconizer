//
//  OptionsViewController.swift
//  Iconology
//
//  Created by Liam Rosenfeld on 2/1/18.
//  Copyright © 2018 Liam Rosenfeld. All rights reserved.
//

import Cocoa

class OptionsViewController: NSViewController {
    
    // MARK: - Setup
    @IBOutlet weak var presetSelector: NSPopUpButton!
    @IBOutlet weak var prefixView: NSView!
    @IBOutlet weak var prefixTextBox: NSTextField!
    @IBOutlet weak var prefixPreview: NSTextField!
    
    var imageURL: URL?
    var saveDirectory: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI Preperation
        prefixView.isHidden = true
        presetSelector.removeAllItems()
        
        // Presets
        UserPresets.loadPresets()
        if UserPresets.presets.isEmpty {
            DefaultPresets().addDefaults()
        }
        for preset in UserPresets.presets {
            presetSelector.addItem(withTitle: preset.name)
        }
        selectedPreset(self)
        
        // Set Reload Notification
        NotificationCenter.default.addObserver(forName: NSNotification.Name("DismissSheet"), object: nil, queue: nil) { notification in
            self.presetSelector.removeAllItems()
            for preset in UserPresets.presets {
                self.presetSelector.addItem(withTitle: preset.name)
            }
            self.selectedPreset(self)
        }
    }
    
    func segue(to: String) {
        if (to == "SavedVC"){
            let savedViewController = storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("SavedViewController")) as? SavedViewController
            savedViewController?.savedDirectory = saveDirectory!
            view.window?.contentViewController = savedViewController
        } else if (to == "DragVC") {
            let dragViewController = storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("DragViewController")) as? DragViewController
            view.window?.contentViewController = dragViewController
        }
    }
    
    // MARK: - Actions
    @IBAction func selectedPreset(_ sender: Any) {
        let selectedPreset = presetSelector.indexOfSelectedItem
        
        if selectedPreset != -1 {
            if UserPresets.presets[selectedPreset].usePrefix {
                prefixView.isHidden = false
            } else {
                prefixView.isHidden = true
            }
        } else {
            prefixView.isHidden = true
        }
    }
    
    @IBAction func prefixTextEdited(_ sender: Any) {
        // TODO: Update On Type
        if presetSelector.indexOfSelectedItem < UserPresets.presets.count && presetSelector.indexOfSelectedItem != -1 {
            let sizes = UserPresets.presets[presetSelector.indexOfSelectedItem].sizes
            let prefix = prefixTextBox.stringValue
            if sizes.count > 0 {
                let root = Array(sizes)[Int(arc4random_uniform(UInt32(sizes.count)))].key  // Get random key from sizes
                prefixPreview.stringValue = "Ex: \(prefix)\(root)"
            } else {
                let prefix = prefixTextBox.stringValue
                prefixPreview.stringValue = "Ex: \(prefix)root"
            }
        } else {
            let prefix = prefixTextBox.stringValue
            prefixPreview.stringValue = "Ex: \(prefix)root"
        }
    }
    
    @IBAction func convert(_ sender: Any) {
        // Check User Options
        let selectedPreset = presetSelector.indexOfSelectedItem
        if selectedPreset == -1 {
            // TODO: Warning Popup
            print("ERR: Invalid Preset")
            return
        }
        
        // Get Image from URL
        var imageToConvert: NSImage!
        do {
            imageToConvert = try imageURL?.toImage()
        } catch {
            // TODO: Warning Popup
            print("ERR: File Could No Longer Be Found")
            return
        }
        
        // Where to save
        let chosenFolder = selectFolder()
        if chosenFolder == "canceled" { return }
        saveDirectory = URL(string: "\(chosenFolder)Icons/")
        print(saveDirectory!)
        createFolder(directory: saveDirectory!)
        
        // Convert and Save
        if UserPresets.presets[selectedPreset].usePrefix {
            for (name, size) in UserPresets.presets[selectedPreset].sizes {
                let resizedImage = resize(image: imageToConvert, w: size.x, h: size.y)
                save(at: saveDirectory!, name: "\(prefixTextBox.stringValue)\(name)", image: resizedImage)
            }
        } else {
            for (name, size) in UserPresets.presets[selectedPreset].sizes {
                let resizedImage = resize(image: imageToConvert, w: size.x, h: size.y)
                save(at: saveDirectory!, name: name, image: resizedImage)
            }
        }
        
        segue(to: "SavedVC")
    }
   
    @IBAction func back(_ sender: Any) {
        segue(to: "DragVC")
    }
    
    
}
