extends Label

signal shot_taken(shots)

var shots_taken : int = 0

func increment():
    shots_taken += 1

    if shots_taken > 1:
        text = "%s shots taken" % shots_taken
    else:
        text = "%s shot taken" % shots_taken

    emit_signal("shot_taken", shots_taken)
