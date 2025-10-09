

$(function () {

	$("#tpz_characters").on("click", "#eyes-back-button", function () {
		PlayButtonClickSound();

		$(".eyes-section").fadeOut();
		$(".appearance-section").fadeIn();
	});


	// texture-id adjusters.
	$("#tpz_characters").on("click", "#eyes-texture-id-prev", function () {
		PlayButtonClickSound();

		CURRENT_OVERLAY_INFO_EYES_TEXTURE_ID--;

		if (CURRENT_OVERLAY_INFO_EYES_TEXTURE_ID < 1) {
			CURRENT_OVERLAY_INFO_EYES_TEXTURE_ID = MAX_OVERLAYS_INFO_EYES_TEXTURE_ID;
		}

		$("#eyes-texture-id-currentNumber").text(CURRENT_OVERLAY_INFO_EYES_TEXTURE_ID + " / " + MAX_OVERLAYS_INFO_EYES_TEXTURE_ID);

		$.post("http://tpz_characters/set_eye_textures", JSON.stringify({
			texture_id: CURRENT_OVERLAY_INFO_EYES_TEXTURE_ID,
		}));

	});

	$("#tpz_characters").on("click", "#eyes-texture-id-next", function () {
		PlayButtonClickSound();

		CURRENT_OVERLAY_INFO_EYES_TEXTURE_ID++;

		if (CURRENT_OVERLAY_INFO_EYES_TEXTURE_ID > MAX_OVERLAYS_INFO_EYES_TEXTURE_ID) {
			CURRENT_OVERLAY_INFO_EYES_TEXTURE_ID = 1;
		}

		$("#eyes-texture-id-currentNumber").text(CURRENT_OVERLAY_INFO_EYES_TEXTURE_ID + " / " + MAX_OVERLAYS_INFO_EYES_TEXTURE_ID);

		$.post("http://tpz_characters/set_eye_textures", JSON.stringify({
			texture_id: CURRENT_OVERLAY_INFO_EYES_TEXTURE_ID,
		}));
	});

});

