/**
 * Scale it up so (hopefully) any floating point components disappears,
 * then force it to be an integer with %d.  not using `util.positiontostr`
 * as it uses `%g` and keeps the floating point component.
 * @param position
 */
export function positionToString(position: PositionTable) {
	return string.format('%d%d', position.x * 100, position.y * 100);
}
