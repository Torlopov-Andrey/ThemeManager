// Created by Andrey Torlopov on 14/12/2020.

import UIKit

@objc protocol Weakable: class { }

class Weak<T: Weakable> {
	private(set) weak var value: T?
	var isNil: Bool { value == nil }
	init(value: T?) {
		self.value = value
	}
}
