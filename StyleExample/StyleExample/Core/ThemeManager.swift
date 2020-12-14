// Created by Andrey Torlopov on 14/12/2020.

import UIKit

enum AppStyle {
	case `default`
	case XL

	init(value: UIContentSizeCategory) {
		switch value {
			case .medium:
				self = .default
			default:
				self = .XL
		}
	}
}

@objc protocol Stylable: Weakable {
	@objc func needUpdateStyle()
}

class ThemeManager {
	static var style: AppStyle = .default

	static var contentSizeCategory: UIContentSizeCategory? {
		willSet {
			if contentSizeCategory != nil,
				  newValue != contentSizeCategory {
				updateStyle()
			}
		}
		didSet {
			guard let contentSizeCategory = contentSizeCategory else { return }
			style = AppStyle(value: contentSizeCategory)
		}
	}

	fileprivate static var listeners: [Weak<Stylable>] = []

	fileprivate static func updateStyle() {
		self.listeners = self.listeners.filter { !$0.isNil }
		for item in listeners {
			needUpdateStyle(item.value)
		}
	}
}

extension ThemeManager {
	fileprivate static let serialQueue = DispatchQueue(label: "ThemeManager")

	static func needUpdateStyle(_ noteable: Stylable?) {
		guard let noteable = noteable else { return }
		noteable.needUpdateStyle()
	}

	static func add(_ noteable: Stylable, forceUpdate: Bool = false) {
		serialQueue.sync {
			self.listeners = self.listeners.filter { !$0.isNil }
			self.listeners.append(Weak(value: noteable))

			if forceUpdate {
				needUpdateStyle(noteable)
			}
		}
	}
}
