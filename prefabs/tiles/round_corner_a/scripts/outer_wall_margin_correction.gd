extends CollisionPolygon

export (float) var margin = 0.04

func _ready():
    var newPoly = polygon
    
    newPoly[0] = Vector2(polygon[0].x - margin, polygon[0].y + margin)
    newPoly[1] = Vector2(polygon[1].x + margin, polygon[1].y + margin)

    for i in range(14, 26):
        newPoly[i] = Vector2(polygon[i].x - margin, polygon[i].y + margin)
    
    for i in range(2, 14):
        newPoly[i] = Vector2(polygon[i].x + margin, polygon[i].y - margin)
        
    polygon = newPoly
