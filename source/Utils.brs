
Sub playDefaultClip(app)        
    sizeRect = app.canvas.GetCanvasRect()  
    app.player.SetDestinationRect(sizeRect) 'fullscreen
    
    contentList = []    
        contentList.Push({
            Stream: { url: "http://qthttp.apple.com.edgesuite.net/1010qwoeiuryfg/sl.m3u8" }
            StreamFormat: "hls"
        })       
    app.player.SetContentList(contentList)    
    app.player.play()
    print "playing!"
End Sub

Function LoadNavigationContent(contentURL)
    jsonAsString = ReadAsciiFile(contentURL)
    content = ParseJSON(jsonAsString)
    return content     
End Function