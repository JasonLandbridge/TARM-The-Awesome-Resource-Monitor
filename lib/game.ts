export function getPlayer(playerIndex: number): LuaPlayer | undefined {
	return getPlayers().find((x) => x.index === playerIndex);
}

/**
 * Retrieves all current players of the game
 */
export function getPlayers(): LuaPlayer[] {
	let players: LuaPlayer[] = [];
	// pairs must be used to retrieve the game.players
	for (const [index, player] of pairs(game.players)) {
		players.push(player);
	}

	return players;
}
