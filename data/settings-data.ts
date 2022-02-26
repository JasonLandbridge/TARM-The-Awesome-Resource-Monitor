import Settings from '../constants/settings';
import { OnInit, OnLoad } from '../typings/IEvent';

export class SettingsDataType implements OnLoad, OnInit {
	private _tickBetweenChecks: number = 0;
	private _overlayStep: number = 0;
	private _prefixWithSurface: boolean = false;
	private _entitiesPerTick: number = 0;

	public get TickBetweenChecks(): number {
		return this._tickBetweenChecks;
	}

	public get OverlayStep(): number {
		return this._overlayStep;
	}

	public get PrefixSiteWithSurface(): boolean {
		return this._prefixWithSurface;
	}

	public get EntitiesPerTick(): number {
		return this._entitiesPerTick;
	}

	OnInit(): void {
		this.OnLoad();
	}

	OnLoad(): void {
		this._tickBetweenChecks = settings.global[Settings.TickBetweenChecks].value as number;
		this._overlayStep = settings.global[Settings.OverlayStep].value as number;
		this._prefixWithSurface = settings.global[Settings.PrefixSiteWithSurface].value as boolean;
		this._entitiesPerTick = settings.global[Settings.EntitiesPerTick].value as number;
	}
}

const SettingsData = new SettingsDataType();
export default SettingsData;
