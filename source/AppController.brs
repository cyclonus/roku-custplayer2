

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
    navContent = LoadNavigationContent(navigationContentURL)
             
    controls = {
      menuControl:initMenuControl(navContent)
      playerControl:initPlayerControl()        
    }
    
    app = {
          
      player:player 
      canvas:canvas      
      port:port
      
      'navContent:navContent    
      controls:controls
     
      paint:paintAll
      handleEvents:loopEvents
                      
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
     
    m.canvas.SetLayer(0, { Color: "#6384A6", CompositionMode: "Source" })                 
    ' Do, any painting here through the canvas object     
    for each k in m.controls
      m.controls[k].paint(m.canvas) 
    end for    
                                                                                          
    m.canvas.AllowUpdates(true)
    m.canvas.Show()     
 
End function 
       
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
  handled = false   
   for each k in m.controls
     handled = m.controls[k].onLeftKey(m)
     if(handled)
       print 'handled!'
       Exit For
     end if        
   end for  
     
end Function                                                
           
Function handleUpKey()     
     
   for each k in m.controls
      m.controls[k].onUpKey(m) 
   end for    
end Function
            
Function handleRightKey()
   for each k in m.controls
      m.controls[k].onRightKey(m) 
   end for      
end Function                                            
    
Function handleDownKey() 
   for each k in m.controls
      m.controls[k].onDownKey(m) 
   end for   
end Function                

Function handleExitKey() 
   for each k in m.controls
      m.controls[k].onExitKey(m) 
   end for
return 1
end Function 

Function handleOkKey()     
   for each k in m.controls
      m.controls[k].onOkKey(m) 
   end for   
end Function
                       
' end of interface      