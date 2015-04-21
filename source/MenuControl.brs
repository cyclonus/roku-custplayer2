

Function initMenuControl(menuContent)  
  menu = {
     layerID:1
     menuImageURL:"pkg:/images/light-5-transparent-gradient.png"
     screenPercentage:45 'how much of the scree will be used to draw the menu    
     content:menuContent     
     stat:"hidden"
     paint:paintMenu
     'add user input interface here 
     
     isActive:isMenuActive
     activate:doActivateMenu
     ' private methods
     drawBackground:drawMenuBackground
     drawItems:drawMenuItems
     drawSelectedItems:drawSelectedMenuItems 
     
     onLeftKey:handleMenuLeftKey                                                           
     onUpKey:handleMenuUpKey            
     onRightKey:handleMenuRightKey                                              
     onDownKey:handleMenuDownKey                
     onExitKey:handleMenuExitKey
     onOkKey:handleMenuOkKey        
  }
  return menu
End Function

Function paintMenu(canvas)
  
  m.drawBackground(canvas)
  ' items = DrawMenuItems(items)
  ' items = DrawSelectedItems(items)
   
end Function

Function isMenuActive()
  return m.stat = "visible"
end Function

Function doActivateMenu(activate)
  if(activate)
    m.stat = "visible"
  else
    m.stat = "hidden"
  end if
end Function

Function drawMenuBackground(canvas)
 if(m.isActive())
    screenDimensions = canvas.GetCanvasRect()
    x = screenDimensions.w  - int((m.screenPercentage/100) * screenDimensions.w)        
    y = 0
    w = screenDimensions.w 
    h = screenDimensions.h          
    menuRect = {x: x, y: y, w: w, h: h}     
    items = []                      
    items.Push({
      url: m.menuImageURL
      TargetRect: menuRect
      CompositionMode: "Source_Over" 
    })  
    canvas.SetLayer(m.layerID, items)
 else       
  'canvas.SetLayer(m.layerID, { Color: "#00000000", CompositionMode: "Source" })  
 end if                  
End Function
 
Function drawMenuItems(canvas)
End Function 

Function drawSelectedMenuItems(canvas)
End Function 
 
' user input
Function handleMenuLeftKey(sender)  
  if(m.isActive())
    ' browse Menu logic comes here
  else
    m.activate(true)
    sender.paint()
    return true
  end if
  return false
end Function
                                                           
Function handleMenuUpKey(sender)
  return false
end Function 
            
Function handleMenuRightKey(sender)
  if(m.isActive())
   ' browse Menu logic goes here 
    m.activate(false)
    sender.paint()
    return true
  end if
  return false
end Function 
                                              
Function handleMenuDownKey(sender)
  return false
end Function 
                
Function handleMenuExitKey(sender)
  return false
end Function 

Function handleMenuOkKey(sender)
  return false
end Function   
