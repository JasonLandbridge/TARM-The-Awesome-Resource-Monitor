export interface OnTick {
	OnTick(event: OnTickEvent): void;
}

export interface OnLoad {
	OnLoad(): void;
}

export interface OnInit {
	OnInit(): void;
}
