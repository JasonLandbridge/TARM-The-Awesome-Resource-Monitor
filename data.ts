import { Data } from 'typed-factorio/data/types';
import Events from './constants/events';

declare const data: Data;

data.extend([
	{
		type: 'custom-input',
		name: Events.Toggle_Interface,
		key_sequence: 'F',
		order: 'a',
	},
]);
