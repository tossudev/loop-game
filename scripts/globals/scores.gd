extends Node

var best_score: float = 0.0


func new_score(score: float) -> bool:
	if score > best_score:
		best_score = score
		return true
	return false
