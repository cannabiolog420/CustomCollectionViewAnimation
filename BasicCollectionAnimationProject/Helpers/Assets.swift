//
//  Assets.swift
//  BasicCollectionAnimationProject
//
//  Created by cannabiolog420 on 22.03.2021.
//

import UIKit

// Структура для работы с ресурсами приложения: UIImage, UIColor, UIFont и т.д.
struct Assets {
	@dynamicMemberLookup
	struct Image {
		subscript(dynamicMember member: String) -> UIImage {
			var properties = ["background": UIImage(named: "background")!]
			for index in 1...11 {
				properties["sketch_\(index)"] = UIImage(named: "sketch\(index)")!
			}
			
			return properties[member, default: UIImage()]
		}
	}
	
	static let image = Image()
	
	private init() {}
}
