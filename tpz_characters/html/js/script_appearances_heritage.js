

$(function () {

	$("#tpz_characters").on("click", "#heritage-back-button", function () {
		PlayButtonClickSound();

		$(".heritage-section").fadeOut();
		$(".appearance-section").fadeIn();
	});


	// type adjusters.
	$("#tpz_characters").on("click", "#heritage-type-prev", function () {
		PlayButtonClickSound();

		CURRENT_HERITAGE_TYPE--;

		if (CURRENT_HERITAGE_TYPE < 1) {
			CURRENT_HERITAGE_TYPE = MAX_HERITAGE_TYPES;
		}

		CURRENT_HERITAGE_COLOR_TYPE = 1;

		// REQUEST COLOR BASED ON HERITAGE TYPE
		$("#heritage-type-currentNumber").text(CURRENT_HERITAGE_TYPE + " / " + MAX_HERITAGE_TYPES);

		$.post("http://tpz_characters/set_heritage_textures", JSON.stringify({
			texture_id: CURRENT_HERITAGE_TYPE,
			color: 1,
			action: 'TYPE',
		}));

	});

	$("#tpz_characters").on("click", "#heritage-type-next", function () {
		PlayButtonClickSound();

		CURRENT_HERITAGE_TYPE++;

		if (CURRENT_HERITAGE_TYPE > MAX_HERITAGE_TYPES) {
			CURRENT_HERITAGE_TYPE = 1;
		}

		CURRENT_HERITAGE_COLOR_TYPE = 1;

		$("#heritage-type-currentNumber").text(CURRENT_HERITAGE_TYPE + " / " + MAX_HERITAGE_TYPES);

		$.post("http://tpz_characters/set_heritage_textures", JSON.stringify({
			texture_id: CURRENT_HERITAGE_TYPE,
			color: 1,
			action: 'TYPE',
		}));
	});

	// color adjusters.
	$("#tpz_characters").on("click", "#heritage-color-prev", function () {
		PlayButtonClickSound();

		CURRENT_HERITAGE_COLOR_TYPE--;

		if (CURRENT_HERITAGE_COLOR_TYPE <= 1) {
			CURRENT_HERITAGE_COLOR_TYPE = 1;
		}

		$("#heritage-color-currentNumber").text(CURRENT_HERITAGE_COLOR_TYPE + " / " + MAX_HERITAGE_COLOR_TYPES);
		
		$.post("http://tpz_characters/set_heritage_textures", JSON.stringify({
			texture_id: CURRENT_HERITAGE_TYPE,
			color: CURRENT_HERITAGE_COLOR_TYPE,
			action: 'COLOR',
		}));

	});

	$("#tpz_characters").on("click", "#heritage-color-next", function () {
		PlayButtonClickSound();

		CURRENT_HERITAGE_COLOR_TYPE++;

		if (CURRENT_HERITAGE_COLOR_TYPE >= MAX_HERITAGE_COLOR_TYPES) {
			CURRENT_HERITAGE_COLOR_TYPE = 1;
		}

		$("#heritage-color-currentNumber").text(CURRENT_HERITAGE_COLOR_TYPE + " / " + MAX_HERITAGE_COLOR_TYPES);

		$.post("http://tpz_characters/set_heritage_textures", JSON.stringify({
			texture_id: CURRENT_HERITAGE_TYPE,
			color: CURRENT_HERITAGE_COLOR_TYPE,
			action: 'COLOR',
		}));
	});

});

