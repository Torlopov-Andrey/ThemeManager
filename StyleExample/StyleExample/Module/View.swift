// Created by Andrey Torlopov on 14/12/2020.

import UIKit

protocol ViewStyle {
	static var font: UIFont { get }
	static var titleColor: UIColor { get }
}

enum ViewNormalStyle: ViewStyle {
	static var font = UIFont.systemFont(ofSize: 14)
	static var titleColor: UIColor = .black
}

enum ViewLargeStyle: ViewStyle {
	static var font = UIFont.systemFont(ofSize: 30, weight: .bold)
	static var titleColor: UIColor = .gray
}

protocol DisplayView: UIView {
	func foo()
}

class View<Style: ViewStyle>: UIView, DisplayView {

	private lazy var titleLabel: UILabel = {
		$0.textColor = Style.titleColor
		$0.font = Style.font
		$0.textAlignment = .center
		return $0
	}(UILabel())

	private var style: AppStyle

	init(frame: CGRect = .zero, viewModel: ViewModel, style: AppStyle = .default) {
		self.style = style
		super.init(frame: frame)
		titleLabel.text = viewModel.title
		backgroundColor = .white
		addSubviews()
		makeConstraints()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func addSubviews() {
		addSubview(titleLabel)
	}

	private func makeConstraints() {
		titleLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
			titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
			titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30)
		])
	}

	func foo() {
		print(#function)
	}
}
