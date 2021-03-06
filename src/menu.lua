local composer = require( "composer" )
local soundTable = require("soundTable")
local scene = composer.newScene()

local widget = require( "widget" )
local utility = require( "utility" )
local ads = require( "ads" )

local params

local myData = require( "mydata" )

local function handlePlayButtonEvent( event )
    if ( "ended" == event.phase ) then

        local menu = event.target.params.menu

        audio.play(soundTable.click)

        print(menu.bgm, "channel")
        audio.stop(menu.bgm)

        composer.gotoScene("gameScene", { effect = "crossFade", time = 333 })
    end
end

local function handleHelpButtonEvent( event )
    if ( "ended" == event.phase ) then
        audio.play(soundTable.click)
        composer.gotoScene("help", { effect = "crossFade", time = 333, isModal = true })
    end
end

local function handleCreditsButtonEvent( event )

    if ( "ended" == event.phase ) then
        audio.play(soundTable.click)
        composer.gotoScene("gamecredits", { effect = "crossFade", time = 333 })
    end
end

local function handleSettingsButtonEvent( event )

    if ( "ended" == event.phase ) then
        audio.play(soundTable.click)
        composer.gotoScene("gamesettings", { effect = "crossFade", time = 333 })
    end
end

--
-- Start the composer event handlers
--
function scene:create( event )
    local sceneGroup = self.view

    params = event.params

    self.bgm = audio.play(audio.loadStream("audio/intro.wav"), {loops = -1})
        
    --
    -- setup a page background, really not that important though composer
    -- crashes out if there isn't a display object in the view.
    --
    local screen_adjustment = 0.4
    --local background = display.newRect( 0, 0, 570, 360 )
    local background = display.newImage("images/background3.jpg",true)
    background.xScale = (screen_adjustment  * background.contentWidth)/background.contentWidth
    background.yScale = background.xScale
    background.x = display.contentWidth / 2
    background.y = display.contentHeight / 2
    sceneGroup:insert( background )

    --local title = display.newText("Prime Ritual", 125, 32, native.systemFontBold, 32 )
    local title = display.newImage("images/gameTitle.png", true)
    title.x = display.contentCenterX + 10
    title.y = 40
    --title:setFillColor( 0 )
    sceneGroup:insert( title )

    -- Create the widget
    local playButton = widget.newButton({
        id = "button1",
        --label = "Play",
        defaultFile = "button/playButton.png",
        overFile = "button/playButtonPressed.png",
        onEvent = handlePlayButtonEvent
    })

    playButton.params = {menu = self}
    
    -- local playButton = display.newImage("button/playButton.png")
    playButton.x = display.contentCenterX - 120
    playButton.y = display.contentCenterY - 30
    sceneGroup:insert( playButton )

    -- Create the widget
    local settingsButton = widget.newButton({
        id = "button2",
        defaultFile = "button/settingsButton.png",
        overFile = "button/settingsButtonPressed.png",
        onEvent = handleSettingsButtonEvent
    })
    
    settingsButton.x = display.contentCenterX + 120
    settingsButton.y = display.contentCenterY - 40
    sceneGroup:insert( settingsButton )

    -- Create the widget
    local helpButton = widget.newButton({
        id = "button3",
        defaultFile = "button/helpButton.png",
        overFile = "button/helpButtonPressed.png",
        onEvent = handleHelpButtonEvent
    })

    helpButton.x = display.contentCenterX - 120
    helpButton.y = display.contentCenterY + 90
    sceneGroup:insert( helpButton )

    -- Create the widget
    local creditsButton = widget.newButton({
        id = "button4",
        defaultFile = "button/creditsButton.png",
        overFile = "button/creditsButtonPressed.png",
        onEvent = handleCreditsButtonEvent
    })
    
    creditsButton.x = display.contentCenterX + 120
    creditsButton.y = display.contentCenterY + 85
    sceneGroup:insert( creditsButton )

end

function scene:show( event )
    local sceneGroup = self.view

    params = event.params
    utility.print_r(event)

    if params then
        print(params.someKey)
        print(params.someOtherKey)
    end

    if event.phase == "did" then

        if self.bgm and not audio.isChannelActive( self.bgm ) then
            self.bgm = audio.play(audio.loadStream("audio/intro.wav"), {loops = -1})
        end
        composer.removeScene( "game" ) 
    end
end

function scene:hide( event )
    local sceneGroup = self.view

    
    if event.phase == "will" then

    end

end

function scene:destroy( event )
    local sceneGroup = self.view
    
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
return scene
