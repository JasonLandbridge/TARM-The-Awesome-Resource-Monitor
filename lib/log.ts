import { getPlayer, getPlayers } from './game';

export default class Log {
	// region Debug
	public static debug(playerIndex: number, message: string) {
		getPlayer(playerIndex)?.print(`[DEBUG]: ${message}`);
	}

	public static debugAll(message: string) {
		for (const player of getPlayers()) {
			this.debug(player.index, message);
		}
	}
	// endregion

	// region Debug
	public static info(playerIndex: number, message: string) {
		getPlayer(playerIndex)?.print(`[INFO]: ${message}`);
	}

	public static infoAll(message: string) {
		for (const player of getPlayers()) {
			this.debug(player.index, message);
		}
	}
	// endregion

	public static warn(playerIndex: number, message: string) {
		// yellow color
		getPlayer(playerIndex)?.print(`[WARN]: ${message}`, { r: 255, g: 204, b: 0 });
	}

	// region Error

	public static error(playerIndex: number, message: string) {
		// red color
		getPlayer(playerIndex)?.print(`[ERROR]: ${message}`, { r: 204, g: 51, b: 0 });
	}

	public static errorAll(message: string) {
		for (const player of getPlayers()) {
			this.error(player.index, message);
		}
	}
	// endregion
}
