export default interface IEvent {
	OnLoad(): void;
	OnTick(event: OnTickEvent): void;
}
