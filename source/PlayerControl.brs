
Function initPlayerControl()
  playerCtrl = { 
     layerID:2
     playerImageURL:"pkg:/images/light-5-transparent-gradient.png"   
     screenPercentage:38 'how much of the scree will be used to draw the VP controls  
     stat : "hidden"
     paint:paintPlayerCtrl
     ' user input interface
     isActive:isPlayerCtrlActive 
     activate:doActivatePlayer 
     onLeftKey:handlePlayerLeftKey                                                           
     onUpKey:handlePlayerUpKey            
     onRightKey:handlePlayerRightKey                                              
     onDownKey:handlePlayerDownKey                
     onExitKey:handlePlayerExitKey
     onOkKey:handlePlayerOkKey           
  }
  return playerCtrl
End Function

Function paintPlayerCtrl(canvas)
if(m.isActive())
    print "player paint"
    screenDimensions = canvas.GetCanvasRect()
    x = 0      
    y = screenDimensions.h  - int((m.screenPercentage/100) * screenDimensions.h)     
    w = screenDimensions.w 
    h = screenDimensions.h              
    playerRect = {x: x, y: y, w: w, h: h}
    print playerRect     
    items = []                      
    items.Push({
      url: m.playerImageURL
      TargetRect: playerRect
      CompositionMode: "Source_Over" 
    })  
    canvas.SetLayer(m.layerID, items)
 else       
 ' canvas.SetLayer(m.layerID, { Color: "#00000000", CompositionMode: "Source" })  
 end if                  
End Function

Function isPlayerCtrlActive()
 return m.stat = "visible"
end Function

Function doActivatePlayer(activate)
  if(activate)
    m.stat = "visible"
  else
    m.stat = "hidden"
  end if
end Function

Function handlePlayerLeftKey(sender) 
 return false
end Function                   
                                         
Function handlePlayerUpKey(sender)
print "handlePlayerUpKey"
 if(m.isActive())
    ' browse Menu logic comes here
  else
    m.activate(true)
    sender.paint()
    return true
  end if  
   return false 
end Function
            
Function handlePlayerRightKey(sender)
 return false 
end Function
                                              
Function handlePlayerDownKey(sender)
print "handlePlayerDownKey"
 if(m.isActive())
   ' browse Menu logic goes here 
    m.activate(false)
    sender.paint()
    return true
  end if
   return false
 
end Function
                
Function handlePlayerExitKey(sender)
 return false 
end Function

Function handlePlayerOkKey(sender)
 return false 
end Function    