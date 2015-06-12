typealias Position = CGPoint
typealias Distance = CGFloat

func inRange1(target: Position, range: Distance) -> Bool {
	return sqrt(target.x * target.x + target.y * target.y) <= range
}

func inRange2(target: Position, ownPosition: Position, range: Distance) -> Bool {
	let dx = target.x - ownPosition.x
	let dy = target.y - ownPosition.y
	return sqrt(dx * dx + dy * dy) <=  range
}

let minDistance = 2.0
func inRange3(target: Position, ownPosition: Position, range: Distance) -> Bool {
	let dx = target.x - ownPosition.x
	let dy = target.y - ownPosition.y
	let targetDistance = sqrt(dx * dx + dy * dy)
	return targetDistance <= range && targetDistance > minDistance
}


func inRange4(target: Position, ownPosition: Position, friendly: Position, range: Distance) -> Bool {
	let dx = target.x - ownPosition.x
	let dy = target.y - ownPosition.y
	let targetDistance = sqrt(dx * dx + dy * dy)
	let friendlyDx = friendly.x - target.x
	let friendlyDy = friendly.y - target.y
	let friendlyDistance = sqrt(friendlyDx * friendlyDx + friendlyDy * friendlyDy)

	return targetDistance <= range && targetDistance > minDistance && friendlyDistance > minDistance
}

// functional way
typealias Region = Position -> Bool

func circle(radius: Position) -> Region {
	return { point in 
		sqrt(point.x * point.x + point.y * point.y) <= radius
	}
}

func circle2(radius: Distance, center: Position) -> Region {
	return { point in 
		let shiftedPoint = Position(x: point.x - center.x, y: point.y - center.y)
		return sqrt(shiftedPoint.x * shiftedPoint.x + shiftedPoint.y * shiftedPoint.y) <= radius
	}
}

func shift(offset: Position, region: Region) -> Region {
	return {point in
		let shiftedPoint = Position(x: point.x - offset.x, y: point.y - offset.y)
		return region(shiftedPoint)
	}
}