import { General } from '../constants';
import { Extend } from '../declarations/globalState';

/**
 * Scale it up so (hopefully) any floating point components disappears,
 * then force it to be an integer with %d.  not using `util.positiontostr`
 * as it uses `%g` and keeps the floating point component.
 * @param position
 */
export function positionToString(position: PositionTable) {
	return string.format('%d%d', position.x * 100, position.y * 100);
}

export function findResourceAt(surface: LuaSurface, position: MapPositionTable) {
	// The position we get is centered in its tile (e.g., {8.5, 17.5}).
	// Sometimes, the resource does not cover the center, so search the full tile.

	let top_left: MapPositionTable = { x: position.x - 0.5, y: position.y - 0.5 };
	let bottom_right: MapPositionTable = { x: position.x + 0.5, y: position.y + 0.5 };
	let stuff = surface.find_entities_filtered({ area: [top_left, bottom_right], type: 'resource' });

	if (stuff.length < 1) {
		return undefined;
	}

	//there should never be another resource at the exact same coordinates
	return stuff[1];
}

export function findCenter(area: Extend): PositionArray {
	let xPos = (area.left + area.right) / 2;
	let yPos = (area.top + area.bottom) / 2;

	return [Math.floor(xPos), Math.floor(yPos)];
}

export function shiftPosition(position: MapPositionTable, direction: string) {
	switch (direction) {
		case General.Directions[1]: // direction.north
			return { x: position.x, y: position.y - 1 };
		case General.Directions[2]: // direction.northeast
			return { x: position.x + 1, y: position.y - 1 };
		case General.Directions[3]: // direction.east
			return { x: position.x + 1, y: position.y };
		case General.Directions[4]: // direction.southeast
			return { x: position.x + 1, y: position.y + 1 };
		case General.Directions[5]: // direction.south
			return { x: position.x, y: position.y + 1 };
		case General.Directions[6]: // direction.southwest
			return { x: position.x - 1, y: position.y + 1 };
		case General.Directions[7]: // direction.west
			return { x: position.x - 1, y: position.y };
		case General.Directions[8]: // direction.northwest
			return { x: position.x - 1, y: position.y - 1 };
		default:
			return position;
	}
}

export function getOctantName(vector: PositionArray) {
	let radians = Math.atan2(vector[1] /* Y */, vector[0] /* X */);
	let octant = Math.floor((8 * radians) / (2 * Math.PI) + 8.5) % 8;
	return General.OctantNames[octant];
}
