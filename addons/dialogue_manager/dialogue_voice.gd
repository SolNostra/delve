extends Resource
class_name DialogueVoice
## This controls the sounds made by the text while typing.

## SFX played every character typed.
@export var typing_sfx: AudioStream

## Max randomized distance from the base pitch of the audio.
@export var pitch_variance: float = 0.5
