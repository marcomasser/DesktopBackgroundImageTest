//
//  ViewController.swift
//  Desktop Background Image Test
//
//  Created by Marco Masser on 2020-02-22.
//  Copyright © 2020 Objective Development. All rights reserved.
//

import AppKit

class ViewController: NSViewController {

    lazy var popover: NSPopover = {
        let popover = NSPopover()
        popover.contentViewController = PopoverViewController()
        popover.behavior = .transient
        return popover
    }()

    @IBAction func showPopover(_ sender: NSButton) {
        popover.show(
            relativeTo: .zero,
            of: sender,
            preferredEdge: .maxX
        )
    }

}

class PopoverViewController: NSViewController {

    let imageView = NSImageView()
    let radioButton = NSButton(radioButtonWithTitle: "", target: nil, action: nil)

    override func loadView() {
        let view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view = view
    }

    override func viewDidLoad() {
        view.wantsLayer = true
        radioButton.wantsLayer = true

        imageView.imageScaling = .scaleProportionallyDown

        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.setContentHuggingPriority(.required, for: .vertical)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        radioButton.translatesAutoresizingMaskIntoConstraints = false

        let view = self.view
        view.subviews = [imageView, radioButton]

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 640),
            imageView.heightAnchor.constraint(equalToConstant: 400),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1),

            radioButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            radioButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
        ])
    }

    override func viewWillAppear() {
        guard let screen = view.window?.screen else { return }
        print("frameForFullscreenWindow", screen.frameForFullscreenWindow)
        imageView.image = screen.desktopBackgroundImage
    }

}
