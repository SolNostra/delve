extends ResourceComponent
class_name HealthComponent

var health_to_status := {
	0: "dead.",
	25: "critical",
	50: "injured",
	100: "healthy",
}

var health: float:
	get: return resource
	set(value): resource = value

func has_health_remaining() -> bool:
	return has_resource_remaining()

func get_health_percentage() -> float:
	return get_resource_percentage()

## debug

var godmode := false

func toggle_godmode() -> bool:
	godmode = !godmode
	return godmode

## debug end
