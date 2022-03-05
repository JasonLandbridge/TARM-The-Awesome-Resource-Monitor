import { General } from '../constants';
import { Extend } from '../declarations/global-save-state';

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
	return stuff[0];
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

export function sum(values: number[]): number {
	let sum = 0;
	for (const value of values) {
		sum += value;
	}
	return sum;
}

export function generateGuid() {
	return Math.random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15);
}

export function findMajorityResourceEntity(entities: LuaEntity[]): LuaEntity {
	// Count all occurrences of all resource types
	let results: Map<string, number> = new Map<string, number>();
	for (const entity of entities) {
		if (entity.type === 'resource') {
			let currentCount = results.get(entity.name) ?? 0;
			results.set(entity.name, currentCount + 1);
		}
	}

	// Determine the most common resource type in the entities
	let winnerType = [...results.entries()].reduce((a, e) => (e[1] > a[1] ? e : a))[0];

	// Hacky way to hide the possibility of undefined, but we're guaranteed to find something here
	return entities.find((x) => x.name === winnerType) ?? ({} as LuaEntity);
}
