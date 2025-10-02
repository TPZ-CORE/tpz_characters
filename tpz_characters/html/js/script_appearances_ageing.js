

$(function () {

	$("#tpz_characters").on("click", "#ageing-back-button", function () {
		PlayButtonClickSound();

		$(".ageing-section").fadeOut();
		$(".appearance-section").fadeIn();
	});


	// texture-id adjusters.
	$("#tpz_characters").on("click", "#ageing-texture-id-prev", function () {
		PlayButtonClickSound();

		CURRENT_OVERLAY_INFO_AGEING_TEXTURE_ID--;

		if (CURRENT_OVERLAY_INFO_AGEING_TEXTURE_ID < 0) {
			CURRENT_OVERLAY_INFO_AGEING_TEXTURE_ID = MAX_OVERLAYS_INFO_AGEING_TEXTURE_ID;
		}

		CURRENT_OVERLAY_INFO_AGEING_OPACITY = 10;
		$("#ageing-opacity-currentNumber").text("1.0 / 1.0");

		$("#ageing-texture-id-currentNumber").text(CURRENT_OVERLAY_INFO_AGEING_TEXTURE_ID + " / " + MAX_OVERLAYS_INFO_AGEING_TEXTURE_ID);

		$.post("http://tpz_characters/set_ageing_textures", JSON.stringify({
			texture_id: CURRENT_OVERLAY_INFO_AGEING_TEXTURE_ID,
			opacity: CURRENT_OVERLAY_INFO_AGEING_OPACITY,
		}));

	});

	$("#tpz_characters").on("click", "#ageing-texture-id-next", function () {
		PlayButtonClickSound();

		CURRENT_OVERLAY_INFO_AGEING_TEXTURE_ID++;

		if (CURRENT_OVERLAY_INFO_AGEING_TEXTURE_ID > MAX_OVERLAYS_INFO_AGEING_TEXTURE_ID) {
			CURRENT_OVERLAY_INFO_AGEING_TEXTURE_ID = 0;
		}

		CURRENT_OVERLAY_INFO_AGEING_OPACITY = 10;
		$("#ageing-opacity-currentNumber").text("1.0 / 1.0");

		$("#ageing-texture-id-currentNumber").text(CURRENT_OVERLAY_INFO_AGEING_TEXTURE_ID + " / " + MAX_OVERLAYS_INFO_AGEING_TEXTURE_ID);

		$.post("http://tpz_characters/set_ageing_textures", JSON.stringify({
			texture_id: CURRENT_OVERLAY_INFO_AGEING_TEXTURE_ID,
			opacity: CURRENT_OVERLAY_INFO_AGEING_OPACITY,
		}));
	});

	// opacity adjusters.
	$("#tpz_characters").on("click", "#ageing-opacity-prev", function () {
		PlayButtonClickSound();

		CURRENT_OVERLAY_INFO_AGEING_OPACITY--;

		if (CURRENT_OVERLAY_INFO_AGEING_OPACITY <= 0) {
			CURRENT_OVERLAY_INFO_AGEING_OPACITY = 0;
		}

		let opacity_text = convertSelectorValue(CURRENT_OVERLAY_INFO_AGEING_OPACITY);
		$("#ageing-opacity-currentNumber").text(opacity_text + " / 1.0");
		
		$.post("http://tpz_characters/set_ageing_textures", JSON.stringify({
			texture_id: CURRENT_OVERLAY_INFO_AGEING_TEXTURE_ID,
			opacity: CURRENT_OVERLAY_INFO_AGEING_OPACITY,
		}));

	});

	$("#tpz_characters").on("click", "#ageing-opacity-next", function () {
		PlayButtonClickSound();

		CURRENT_OVERLAY_INFO_AGEING_OPACITY++;

		if (CURRENT_OVERLAY_INFO_AGEING_OPACITY >= 10) {
			CURRENT_OVERLAY_INFO_AGEING_OPACITY = 10;
		}

		let opacity_text = convertSelectorValue(CURRENT_OVERLAY_INFO_AGEING_OPACITY);
		$("#ageing-opacity-currentNumber").text(opacity_text + " / 1.0");

		$.post("http://tpz_characters/set_ageing_textures", JSON.stringify({
			texture_id: CURRENT_OVERLAY_INFO_AGEING_TEXTURE_ID,
			opacity: CURRENT_OVERLAY_INFO_AGEING_OPACITY,
		}));
	});

});

