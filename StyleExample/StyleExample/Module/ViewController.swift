//  Created by Andrey Torlopov on 14/12/2020.
//

import UIKit

class ViewController: UIViewController {

	private var contentView: DisplayView = View<ViewNormalStyle>(viewModel: ViewModel(title: "...")) {
		didSet {
			view = contentView
		}
	}

	override func loadView() {
		view = contentView
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		ThemeManager.add(self)
	}

	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		super.traitCollectionDidChange(previousTraitCollection)
		ThemeManager.contentSizeCategory = self.traitCollection.preferredContentSizeCategory
	}
}

extension ViewController: Stylable {
	func needUpdateStyle() {
		switch ThemeManager.style {
			case .default:
				contentView = View<ViewNormalStyle>(viewModel: ViewModel(title: "default"))
			case .XL:
				view = View<ViewLargeStyle>(viewModel: ViewModel(title: "Large!"))
		}
	}
}

