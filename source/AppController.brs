

' Factory method
Function initApp()
   
    player = CreateObject("roVideoPlayer")  
    canvas = createObject("roImageCanvas")               
    port = CreateObject("roMessagePort")
    
    canvas.SetMessagePort(port)   
    canvas.SetRequireAllImagesToDraw(false)
      
    player.SetMessagePort(port)        
    player.SetLoop(false)
    'player.SetPositionNotificationPeriod(5) 
    
    navigationContentURL = "pkg:/json/content.json"
    navContent    = LoadNavigationContent(navigationContentURL) 
    menuControl   = initMenuControl(navContent)
    playerControl = initPlayerControl()
    
   app = {
          
     player:player 
     canvas:canvas 
     
     port:port
     navContent:navContent
     menuControl:menuControl
     playerControl:playerControl
     paint:paintAll
     handleEvents:loopEvents
     activeControl:getScreenActiveControl
     
     showMenu:showMenuControl
     hideMenu:hideMenuControl
     
     onLeftKey:handleLeftKey                                                           
     onUpKey:handleUpKey            
     onRightKey:handleRightKey                                              
     onDownKey:handleDownKey                
     onExitKey:handleExitKey
     onOkKey:handleOkKey           
   }
   
   return app
   
End Function

Function paintAll()
    m.canvas.AllowUpdates(false)          
    m.canvas.Clear()  
    'm.canvas.SetLayer(0, { Color: "#00000000", CompositionMode: "Source" })
        
    ' Do, any painting here through the canvas object 
    m.menuControl.paint(m.canvas) 
    'm.playerControl.paint(m.canvas)    
                                                                                          
    m.canvas.AllowUpdates(true)
    m.canvas.Show()     
 
End function 

Function getScreenActiveControl()
  ' Here, There can only be one control active at the time
  ' Such logic I manage by hand
  ' bigger applications could use some kind of manager   
  if( m.menucontrol.isActive() )
   return m.menuControl
  end if
  
  if( m.playerControl.isActive() )
   return m.playerControl
  end if
  
  return invalid
End Function    
   
Function showMenuControl()
   m.menuControl.activate(true)
   m.paint()
End Function

Function hideMenuControl()
   m.menuControl.activate(false)
   m.paint()
End Function
    
Function loopEvents()

   while true                                                           
    event = wait(0, m.port)                        
    if (event<> invalid)
        'print "events loop"
        if (event.isRemoteKeyPressed())
            index = event.GetIndex()
            print index               
            if (index = 4) 'Left, pulls out the menu                    
                m.onLeftKey()                                                 
            else if (index = 2) 'Up    
                m.onUpKey()
            else if (index = 5) 'Right,  
                m.onRightKey()                                            
            else if (index = 3) 'Down
                m.onDownKey()                
            else if (index = 6) 'ok, 
                m.onOkKey()                     
            else if (index = 0) 'Exit, exits app, if no control is visible  
                if(m.onExitKey() = 1)                    
                   ExitWhile
                endif   
            endif                               
        endif
    endif           
   end while

End function

'If I had interfaces, this would become 'IUserInput'   
Function handleLeftKey()
   control = m.activeControl()
   if( control <> invalid )
     control.onLeftKey()   
   else
     m.showMenu() ' This function should change flags as required then call paintAll   
   end if
end Function                                                
           
Function handleUpKey() 
   control = m.activeControl()
   if( control <> invalid )
     control.onUpKey()
   end if
end Function
            
Function handleRightKey() 
   control = m.activeControl()
   if( control <> invalid )
     control.onRightKey()
   else
     m.hideMenu() 
   end if
end Function                                            
    
Function handleDownKey() 
   control = m.activeControl()
   if( control <> invalid )
     control.onDownKey()
   
   end if
end Function                

Function handleExitKey() 
   control = m.activeControl()
   if( control <> invalid )
     control.onExitKey()
   end if
return 1
end Function 

Function handleOkKey()
  control = m.activeControl()
   if( control <> invalid )
     control.onOkKey()
   end if
end Function
                       
' end of interface      