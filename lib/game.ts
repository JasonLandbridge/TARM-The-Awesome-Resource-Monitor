export function getPlayer(playerIndex: number): LuaPlayer | undefined {
	if (playerIndex <= 0) {
		return undefined;
	}
	return game.players[playerIndex];
}

export function getPlayers(): LuaPlayer[] {
	return game.players as never as LuaPlayer[];
}
