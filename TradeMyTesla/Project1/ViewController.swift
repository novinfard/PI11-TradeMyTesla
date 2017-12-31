//
//  ViewController.swift
//  Project1
//
//  Created by Soheil on 28/12/2017.
//  Copyright © 2017 Soheil Novinfard. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var stackView: UIStackView!
	@IBOutlet weak var model: UISegmentedControl!
	@IBOutlet weak var upgrades: UISegmentedControl!
	@IBOutlet weak var mileageLabel: UILabel!
	@IBOutlet weak var mileage: UISlider!
	@IBOutlet weak var condition: UISegmentedControl!
	@IBOutlet weak var valuation: UILabel!
	let cars = Cars()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		stackView.setCustomSpacing(30, after: model)
		stackView.setCustomSpacing(30, after: upgrades)
		stackView.setCustomSpacing(30, after: mileage)
		stackView.setCustomSpacing(60, after: condition)
		
		calculateValue(self)
	}
	
	@IBAction func calculateValue(_ sender: Any) {
		// display formatted miles
		let formatter = NumberFormatter()
		formatter.numberStyle = .decimal
		formatter.maximumFractionDigits = 0
		let formattedMileage = formatter.string(for: mileage.value) ?? "0"
		mileageLabel.text = "MILEAGE (\(formattedMileage) miles)"
		
		// create a prediction by passing in all its input from our UI
		if let prediction = try? cars.prediction(model: Double(model.selectedSegmentIndex), premium: Double(upgrades.selectedSegmentIndex), mileage: Double(mileage.value), condition: Double(condition.selectedSegmentIndex)) {
			// clamp the price so it's at least $2000
			let clampedValuation = max(2000, prediction.price)
			
			// make our number formatter output currencies
			formatter.numberStyle = .currency
			
			// display the valuation
			valuation.text = formatter.string(for: clampedValuation)
			
		}
		else {
			// something went wrong!
			valuation.text = "Error"
		}
	}

}

