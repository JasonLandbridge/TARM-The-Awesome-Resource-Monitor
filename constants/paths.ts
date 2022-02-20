import General from './general';

export default class Paths {
	public static Graphics(fileName: string): string {
		return `__${General.ModName}__/graphics/${fileName}`;
	}
}
