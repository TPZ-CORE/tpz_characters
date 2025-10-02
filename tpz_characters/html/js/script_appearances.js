

$(function () {

	$("#tpz_characters").on("click", "#appearance-back-button", function () {
		PlayButtonClickSound();

		$(".appearance-section").fadeOut();
		$(".main-section").fadeIn();
	});

	$("#tpz_characters").on("click", "#appearance-categories-list-name", function () {
		PlayButtonClickSound();

		let $button = $(this);
		let $section = $button.attr('category');

		if ($section == '.height-section') {
			$.post('http://tpz_characters/set_height', JSON.stringify({}));
			return;
		}

		if (($section == '.lifestyle-section') || ($section == '.bodyfeatures-section')) {
			return;
		}

		$(".appearance-section").fadeOut();
		$($section).fadeIn();
	});

});

