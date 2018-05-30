flow = new FlowComponent
flow.showNext(Home)
flow.footer = bottomNav
flow.header = topNav

Framer.Device.deviceType = "apple-iphone-8-silver"

continueButton.onTap ->
	flow.showNext(Reading)

flow.onTransitionStart (before, after) ->
	headerLabel.text = after.name.toUpperCase()

mainScroll.scroll.enabled = true

home.children[0].stroke = "#000"

highlight_word.onTap ->
	flow.showNext(Define)

footer_buttons = [home, search, library, user]
pages = [Home, Browse, Your_Library, Profile]

footer_listener = (event, layer) ->
	current = pages.indexOf(flow.current)
	next = footer_buttons.indexOf(layer)
	if current == next
		return
	if next > current
		flow.showNext(pages[next])
	else
		flow.showPrevious(pages[next])
	for button in footer_buttons
		if footer_buttons.indexOf(button) == next
			button.children[0].stroke = "#000"
		else
			button.children[0].stroke = "#bbb"

for button in footer_buttons
	button.onTap footer_listener
	
sectionOne.onTap ->
	flow.showNext(Competency)
	
discoverClick.onTap ->
	flow.showNext(Discover)

homeBookItems = []

fadeAnim = (itemList, initialDelay=0) ->
	BOOK_Y_OFFSET = 15
	
	for item, index in itemList
		item.y += BOOK_Y_OFFSET
		item.opacity = 0

		item.animate
			y: item.y - BOOK_Y_OFFSET
			opacity: 1
			options:
				delay: 0.05*index + initialDelay
				curve: "spring"

fadeAnim [
	mainHeader, bookOne, mainAuthorOne, mainTitleOne, bookTwo, mainAuthorTwo,
	mainTitleTwo, bookThree, mainAuthorThree, mainTitleThree, mainDiscover,
	mainDiscoverP, discoverClick
]

bookOne.onTap ->
	flow.showNext(Selected_Book)

progressOne.width = 0
progressTwo.width = 0
progressThree.width = 0

bookThree.onAnimationEnd ->
	progressOne.animate
		width: 77
		options:
			curve: Bezier
			
	progressTwo.animate
		width: 115
		options:
			delay: 0.3
			curve: Bezier
			
	progressThree.animate
		width: 34
		options:
			delay: 0.6
			curve: Bezier

blue.scale = 0.9
blue.opacity = 0

yellow.scale = 0.9
yellow.opacity = 0

orange.scale = 0.9
orange.opacity = 0

discoverH1.y = 118
discoverH1.opacity = 0

discoverP.y = 163
discoverP.opacity = 0

blue.onTap ->
	flow.showNext(Selected_Book)
	
flow.onTransitionStart (before, after) ->
	if after == Browse
		fadeAnim [
			searchBar, browseH1, browseBookOne, browseAuthorOne, browseTitleOne,
			browseBookTwo, browseAuthorTwo, browseTitleTwo, browseBookThree,
			browseAuthorThree, browseTitleThree, browseH2, browseBookFour,
			browseBookFive, browseBookSix
		], 0.5
		
	if after == Profile
		fadeAnim [
			sectionOne, sectionTwo, sectionThree
		], 0.5

flow.onTransitionEnd ->
	if flow.current == Discover
		discoverH1.animate
			y: 103
			opacity: 1
			
		discoverP.animate
			y: 148
			opacity: 1
			options:
				delay: 0.1
			
		discoverH1.onAnimationEnd ->
			blue.animate
				scale: 1.2
				opacity: 1
				options:
					curve: "spring"
					
			blue.onAnimationEnd ->
				yellow.animate
					scale: 1.2
					opacity: 1
					options:
						curve: "spring"
					
			yellow.onAnimationEnd ->
				orange.animate
					scale: 1.2
					opacity: 1
					options:
						curve: "spring"