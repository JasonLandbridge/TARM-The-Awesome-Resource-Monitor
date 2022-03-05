import Log from './log';
import { YarmForceData, YarmGlobalState, YarmPlayerData, YarmTrackingData } from '../typings/yarm-global-state';
import Global from '../data/global-save-data';
import { ForceData, TrackingData } from '../declarations/global-save-state';
import { table } from 'util';
import { positionToString } from './common';

export function importYarmData() {
	if (remote.interfaces['YARM'] && remote.interfaces['YARM'].get_global_data) {
		let globalState: YarmGlobalState = remote.call('YARM', 'get_global_data');
		if (globalState && Object.keys(globalState).length > 0) {
			Log.infoAll(`Start of importing YARM data`);
			let resourceEntities = globalState.ore_tracker.entities;
			migrateOreTracker(resourceEntities);
			Log.infoAll(`Imported the resource entities of YARM`);
			migrateForceData(resourceEntities, globalState.force_data);
			Log.infoAll(`Imported the force data of YARM`);
			migratePlayerData(globalState.player_data);
			Log.infoAll(`Imported the player data of YARM`);
			Log.infoAll(`Successfully imported YARM data`);
			return;
		}
		Log.errorAll('Yarm import failed, YARM global contained no values');
	}
}

function migrateOreTracker(entities: YarmTrackingData[]) {
	let newTrackedResources: Record<string, TrackingData> = table.deepcopy(Global.trackedResources);

	for (const yarmEntity of entities) {
		let key = positionToString(yarmEntity.position);
		newTrackedResources[key] = {
			entity: yarmEntity.entity,
			position: yarmEntity.position,
			resourceAmount: yarmEntity.resource_amount,
			valid: yarmEntity.valid,
		};
	}

	Global.setAllTrackedResources(newTrackedResources);
}

function migrateForceData(entities: YarmTrackingData[], forceDatum: Record<string, YarmForceData>) {
	let entries = Object.entries(forceDatum);

	let newForceData: Record<string, ForceData> = table.deepcopy(Global.forceData);
	for (const [index, [key, value]] of entries.entries()) {
		if (!newForceData[key]) {
			newForceData[key] = { resourceSites: [] };
		}

		for (const [name, yarmResourceSite] of Object.entries(value.ore_sites)) {
			newForceData[key].resourceSites.push({
				totalAmount: yarmResourceSite.amount,
				addedAt: yarmResourceSite.added_at,
				center: yarmResourceSite.center,
				entityCount: yarmResourceSite.entity_count,
				etdMinutes: yarmResourceSite.etd_minutes,
				extents: yarmResourceSite.extents,
				force: yarmResourceSite.force,
				initialAmount: yarmResourceSite.initial_amount,
				lastModifiedAmount: yarmResourceSite.last_modified_amount,
				lastOreCheck: yarmResourceSite.last_ore_check,
				name: yarmResourceSite.name,
				oreName: yarmResourceSite.ore_name,
				orePerMinute: yarmResourceSite.ore_per_minute,
				oreType: yarmResourceSite.ore_type,
				remainingPerMille: yarmResourceSite.remaining_permille,
				surface: yarmResourceSite.surface,
				trackedPositionKeys: convertTrackerIndicesToPositionKeys(entities, yarmResourceSite.tracker_indices),
			});
		}
	}
}

function convertTrackerIndicesToPositionKeys(entities: YarmTrackingData[], trackerIndices: Record<int, boolean>) {
	let positionKeys: Record<string, boolean> = {};

	for (const [key, value] of Object.entries(trackerIndices)) {
		let entity = entities[Number(key)];
		if (!entity) {
			Log.errorAll(`convertTrackerIndicesToPositionKeys() => entity could not be found with key ${key}`);
			continue;
		}

		let positionKey = positionToString(entity.position);
		positionKeys[positionKey] = value;
	}

	return positionKeys;
}

function migratePlayerData(yarmPlayerDatum: Record<int, YarmPlayerData>) {
	let playerDatum = table.deepcopy(Global.playerData);

	let yarmPlayerDatumEntries = Object.entries(yarmPlayerDatum);
	for (const playerData of playerDatum) {
		let yarmPlayerDataEntry = yarmPlayerDatumEntries.find(([index, value]) => Number(index) === playerData.index);
		if (yarmPlayerDataEntry) {
			playerData.guiUpdateTicks = yarmPlayerDataEntry[1].gui_update_ticks;
		}
	}

	Global.setAllPlayerData(playerDatum);
}
