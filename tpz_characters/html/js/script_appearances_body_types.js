

$(function () {

	function UpdateLuaPost(part){

		$.post("http://tpz_characters/set_body_type", JSON.stringify({
			body: CURRENT_BODY_TYPE,
			waist: CURRENT_BODY_WAIST_TYPE,
			torso: CURRENT_BODY_TORSO_TYPE,
			legs: CURRENT_BODY_LEGS_TYPE,
			action: part,
		}));
	}

	$("#tpz_characters").on("click", "#body-back-button", function () {
		PlayButtonClickSound();

		$(".body-section").fadeOut();
		$(".appearance-section").fadeIn();
	});


	$("#tpz_characters").on("click", "#body-type-prev", function () {
		PlayButtonClickSound();

		CURRENT_BODY_TYPE--;

		if (CURRENT_BODY_TYPE < 1) {
			CURRENT_BODY_TYPE = MAX_BODY_TYPES;
		}

		$("#body-type-currentNumber").text(CURRENT_BODY_TYPE + " / " + MAX_BODY_TYPES);

		UpdateLuaPost("BODY_TYPE");

	});

	$("#tpz_characters").on("click", "#body-type-next", function () {
		PlayButtonClickSound();

		CURRENT_BODY_TYPE++;

		if (CURRENT_BODY_TYPE > MAX_BODY_TYPES) {
			CURRENT_BODY_TYPE = 1;
		}

		$("#body-type-currentNumber").text(CURRENT_BODY_TYPE + " / " + MAX_BODY_TYPES);
		
		UpdateLuaPost("BODY_TYPE");
	});

	$("#tpz_characters").on("click", "#body-waist-prev", function () {
		PlayButtonClickSound();

		CURRENT_BODY_WAIST_TYPE--;

		if (CURRENT_BODY_WAIST_TYPE < 1) {
			CURRENT_BODY_WAIST_TYPE = MAX_BODY_WAIST_TYPES;
		}

		$("#body-waist-currentNumber").text(CURRENT_BODY_WAIST_TYPE + " / " + MAX_BODY_WAIST_TYPES);

		UpdateLuaPost("WAIST");

	});

	$("#tpz_characters").on("click", "#body-waist-next", function () {
		PlayButtonClickSound();

		CURRENT_BODY_WAIST_TYPE++;

		if (CURRENT_BODY_WAIST_TYPE > MAX_BODY_WAIST_TYPES) {
			CURRENT_BODY_WAIST_TYPE = 1;
		}

		$("#body-waist-currentNumber").text(CURRENT_BODY_WAIST_TYPE + " / " + MAX_BODY_WAIST_TYPES);

		UpdateLuaPost("WAIST");
	});

	$("#tpz_characters").on("click", "#body-torso-prev", function () {
		PlayButtonClickSound();

		CURRENT_BODY_TORSO_TYPE--;

		if (CURRENT_BODY_TORSO_TYPE < 1) {
			CURRENT_BODY_TORSO_TYPE = MAX_BODY_TORSO_TYPES;
		}

		$("#body-torso-currentNumber").text(CURRENT_BODY_TORSO_TYPE + " / " + MAX_BODY_TORSO_TYPES);

		UpdateLuaPost("TORSO");

	});

	$("#tpz_characters").on("click", "#body-torso-next", function () {
		PlayButtonClickSound();

		CURRENT_BODY_TORSO_TYPE++;

		if (CURRENT_BODY_TORSO_TYPE > MAX_BODY_TORSO_TYPES) {
			CURRENT_BODY_TORSO_TYPE = 1;
		}

		$("#body-torso-currentNumber").text(CURRENT_BODY_TORSO_TYPE + " / " + MAX_BODY_TORSO_TYPES);

		UpdateLuaPost("TORSO");
	});

	$("#tpz_characters").on("click", "#body-legs-prev", function () {
		PlayButtonClickSound();

		CURRENT_BODY_LEGS_TYPE--;

		if (CURRENT_BODY_LEGS_TYPE < 1) {
			CURRENT_BODY_LEGS_TYPE = MAX_BODY_LEGS_TYPES;
		}

		$("#body-legs-currentNumber").text(CURRENT_BODY_LEGS_TYPE + " / " + MAX_BODY_LEGS_TYPES);

		UpdateLuaPost("LEGS");

	});

	$("#tpz_characters").on("click", "#body-legs-next", function () {
		PlayButtonClickSound();

		CURRENT_BODY_LEGS_TYPE++;

		if (CURRENT_BODY_LEGS_TYPE > MAX_BODY_LEGS_TYPES) {
			CURRENT_BODY_LEGS_TYPE = 1;
		}

		$("#body-legs-currentNumber").text(CURRENT_BODY_LEGS_TYPE + " / " + MAX_BODY_LEGS_TYPES);

		UpdateLuaPost("LEGS");
	});

});

