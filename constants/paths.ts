import General from './general';

export default class Paths {
	public static Graphics(fileName: string): string {
		return `__${General.ModName}__/graphics/${fileName}`;
	}
	public static IconGraphics(fileName: string): string {
		return `__${General.ModName}__/graphics/icons/${fileName}`;
	}
}
