
Function initPlayerControl()
  playerCtrl = { 
     layerID:1   
     stat : "hidden"
     paint:paintPlayerCtrl
     ' user input interface
     isActive:isPlayerControlActive           
  }
  return playerCtrl
End Function

Function paintPlayerCtrl(canvas)

End Function

Function isPlayerControlActive()
  return m.stat = "visible"
end Function