extends StaticBody2D

signal vida_mudou(vida_atual, vida_maxima)
signal celeiro_derrubado

@export var vida_maxima: int = 100
var vida_atual: int

@onready var indicador = $HealthBar

func _ready():
	vida_atual = vida_maxima
	indicador.max_value = vida_maxima
	indicador.value = vida_atual

func tomando(quant : int):
	if vida_atual <= 0:
		return
		
	vida_atual = max(vida_atual-quant, 0)
	indicador.value = vida_atual
	
	vida_mudou.emit(vida_atual, vida_maxima)
	
	if vida_atual == 0:
		celeiro_derrubado.emit()
		print("Celeiro derrubado!")
func _process(_delta):
	if Input.is_action_just_pressed("levar_dano"):
		tomando(10)
