import { getPlayer } from './game';

export default class Log {
	public static debug(playerIndex: number, message: string) {
		getPlayer(playerIndex)?.print(`[DEBUG]: ${message}`);
	}

	public static info(playerIndex: number, message: string) {
		getPlayer(playerIndex)?.print(`[INFO]: ${message}`);
	}

	public static warn(playerIndex: number, message: string) {
		// yellow color
		getPlayer(playerIndex)?.print(`[WARN]: ${message}`, { r: 255, g: 204, b: 0 });
	}

	public static error(playerIndex: number, message: string) {
		// red color
		getPlayer(playerIndex)?.print(`[ERROR]: ${message}`, { r: 204, g: 51, b: 0 });
	}
}
