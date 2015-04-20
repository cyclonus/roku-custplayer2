

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

Function doActivateMenu(active)
  if(active)
    m.stat = "visible"
  else
    m.stat = "hidden"
  end if
end Function

Function drawMenuBackground(canvas)
 if(m.isActive())
   screenDimensions = canvas.GetCanvasRect()
   x = screenDimensions.w  - int((m.screenPercentage/100) * screenDimensions.w)
   print "  new X "+  str(x)     
   y = 0
   w = screenDimensions.w 
   h = screenDimensions.h          
   menuRect = {x: x, y: y, w: w, h: h}     
   items = []                      
   items.Push({
     url: m.menuImageURL
     TargetRect: menuRect
     CompositionMode: "Source" 
   })  
   canvas.SetLayer(m.layerID, items)
 end if                  
End Function
 
Function drawMenuItems(canvas)
End Function 

Function drawSelectedMenuItems(canvas)
End Function 
 
