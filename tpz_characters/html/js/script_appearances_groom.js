

$(function () {


	$("#tpz_characters").on("click", "#groom-back-button", function () {
		PlayButtonClickSound();

		$(".groom-section").hide();
		$(".appearance-section").show();
	});


	$("#tpz_characters").on("click", "#groom-categories-list-name", function () {
		PlayButtonClickSound();

		let $button = $(this);
		let $category = $button.attr('category');
		let $title = $button.attr('title');

		$.post("http://tpz_characters/request_groom_category_data", JSON.stringify({ category: $category, title: $title }));

		$(".groom-section").hide();
		$(".groom-selected-section").show();

	});


	$("#tpz_characters").on("click", "#groom-selected-back-button", function () {
		PlayButtonClickSound();

		$(".groom-selected-section").hide();
		$(".groom-section").show();

	});

	$("#tpz_characters").on("click", "#appearance-categories-list-name", function () {

		let $button = $(this);
		let $section = $button.attr('category');

		if ($section != '.groom-section') {
			return;
		}

		$.post('http://tpz_characters/request_groom_categories', JSON.stringify({}));

		$(".appearance-section").fadeOut();
		$($section).fadeIn();

	});


	$("#tpz_characters").on("click", "#groom-categories-list-name", function () {

		let $button = $(this);
		let $category = $button.attr('category');
		let $title = $button.attr('title');

		$.post('http://tpz_characters/request_selected_groom_data', JSON.stringify({ 
			category: $category,
			title : $title,
		}));

		$(".groom-section").fadeOut();

	});

	$("#tpz_characters").on("click", "#groom-selected-comps-list-prev", function () {
		PlayButtonClickSound();

		let $button = $(this);
		let $category = $button.attr('category');
		let $type = $button.attr('type');

		let text;

		if ($type == 'texture_id') {
			CURRENT_GROOM_CATEGORY_ITEM--;

			if (CURRENT_GROOM_CATEGORY_ITEM < 0 ) {
				CURRENT_GROOM_CATEGORY_ITEM = MAXIMUM_GROOM_CATEGORY_ITEMS;
			}

			CURRENT_GROOM_COLOR_ITEM = 1;
			MAXIMUM_GROOM_OPACITY_ITEM = 10;

			text = CURRENT_GROOM_CATEGORY_ITEM + " / " + MAXIMUM_GROOM_CATEGORY_ITEMS;

		} else if ($type == 'color') {

			if (CURRENT_GROOM_COLOR_ITEM == 1 ) {
				return;
			}

			CURRENT_GROOM_COLOR_ITEM--;

			text = CURRENT_GROOM_COLOR_ITEM + " / " + MAXIMUM_GROOM_COLOR_ITEMS;

		} else if ($type == 'opacity') {

			if (CURRENT_GROOM_OPACITY_ITEM == 0) {
				return;
			}

			CURRENT_GROOM_OPACITY_ITEM--;

			text = convertSelectorValue(CURRENT_GROOM_OPACITY_ITEM) + " / 1.0";

		}

		$(".groom-currentNumber-" + $category + "-" + $type).text(text);

		$.post("http://tpz_characters/set_groom_textures", JSON.stringify({
			texture_id: CURRENT_GROOM_CATEGORY_ITEM,
			color: CURRENT_GROOM_COLOR_ITEM,
			type: $type,
			opacity: CURRENT_GROOM_OPACITY_ITEM,
		}));

	});

	$("#tpz_characters").on("click", "#groom-selected-comps-list-next", function () {
		PlayButtonClickSound();

		let $button = $(this);
		let $category = $button.attr('category');
		let $type = $button.attr('type');

		let text;

		if ($type == 'texture_id') {
			CURRENT_GROOM_CATEGORY_ITEM++;

			if (CURRENT_GROOM_CATEGORY_ITEM > MAXIMUM_GROOM_CATEGORY_ITEMS) {
				CURRENT_GROOM_CATEGORY_ITEM = 0;
			}

			CURRENT_GROOM_COLOR_ITEM = 1;
			MAXIMUM_GROOM_OPACITY_ITEM = 10;

			text = CURRENT_GROOM_CATEGORY_ITEM + " / " + MAXIMUM_GROOM_CATEGORY_ITEMS;

		} else if ($type == 'color') {

			if (CURRENT_GROOM_COLOR_ITEM == MAXIMUM_GROOM_COLOR_ITEMS) {
				return;
			}

			CURRENT_GROOM_COLOR_ITEM++;

			text = CURRENT_GROOM_COLOR_ITEM + " / " + MAXIMUM_GROOM_COLOR_ITEMS;

		} else if ($type == 'opacity') {

			if (CURRENT_GROOM_OPACITY_ITEM == 10) {
				return;
			}

			CURRENT_GROOM_OPACITY_ITEM++;

			text = convertSelectorValue(CURRENT_GROOM_OPACITY_ITEM) + " / 1.0";
		}

		$(".groom-currentNumber-" + $category + "-" + $type).text(text);

		$.post("http://tpz_characters/set_groom_textures", JSON.stringify({
			texture_id: CURRENT_GROOM_CATEGORY_ITEM,
			color: CURRENT_GROOM_COLOR_ITEM,
			type : $type,
			opacity: CURRENT_GROOM_OPACITY_ITEM,
		}));
	});

});

