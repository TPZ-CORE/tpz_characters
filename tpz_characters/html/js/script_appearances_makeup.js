

$(function () {


	$("#tpz_characters").on("click", "#makeup-back-button", function () {
		PlayButtonClickSound();

		$(".makeup-section").hide();
		$(".appearance-section").show();
	});


	$("#tpz_characters").on("click", "#makeup-categories-list-name", function () {
		PlayButtonClickSound();

		let $button = $(this);
		let $category = $button.attr('category');
		let $title = $button.attr('title');

		$.post("http://tpz_characters/request_makeup_category_data", JSON.stringify({ category: $category, title: $title }));

		$(".makeup-section").hide();
		$(".makeup-selected-section").show();

	});


	$("#tpz_characters").on("click", "#makeup-selected-back-button", function () {
		PlayButtonClickSound();

		$(".makeup-selected-section").hide();
		$(".makeup-section").show();

	});

	$("#tpz_characters").on("click", "#appearance-categories-list-name", function () {

		let $button = $(this);
		let $section = $button.attr('category');

		if ($section != '.makeup-section') {
			return;
		}

		$.post('http://tpz_characters/request_makeup_categories', JSON.stringify({}));

		$(".appearance-section").fadeOut();
		$($section).fadeIn();

	});


	$("#tpz_characters").on("click", "#makeup-categories-list-name", function () {

		let $button = $(this);
		let $category = $button.attr('category');
		let $title = $button.attr('title');

		$.post('http://tpz_characters/request_selected_makeup_data', JSON.stringify({ 
			category: $category,
			title : $title,
		}));

		$(".makeup-section").fadeOut();

	});

	$("#tpz_characters").on("click", "#makeup-selected-comps-list-prev", function () {
		PlayButtonClickSound();

		let $button = $(this);
		let $category = $button.attr('category');
		let $type = $button.attr('type');

		let text;

		if ($type == 'texture_id') {

			if (CURRENT_MAKEUP_CATEGORY_ITEM == 0 ) {
				return;
			}

			CURRENT_MAKEUP_CATEGORY_ITEM--;

			text = CURRENT_MAKEUP_CATEGORY_ITEM + " / " + MAXIMUM_MAKEUP_CATEGORY_ITEMS;

		} else if ($type == 'color') {

			if (CURRENT_MAKEUP_COLOR_PRIMARY_ITEM == 0 ) {
				return;
			}

			CURRENT_MAKEUP_COLOR_PRIMARY_ITEM--;

			text = CURRENT_MAKEUP_COLOR_PRIMARY_ITEM + " / " + 10;


		} else if ($type == 'color2') {

			if (CURRENT_MAKEUP_COLOR_SECONDARY_ITEM == 0) {
				return;
			}

			CURRENT_MAKEUP_COLOR_SECONDARY_ITEM--;

			text = CURRENT_MAKEUP_COLOR_SECONDARY_ITEM + " / " + 10;

		} else if ($type == 'variant') {

			if (CURRENT_MAKEUP_VARIANT_ITEM == 0) {
				return;
			}

			CURRENT_MAKEUP_VARIANT_ITEM--;

			text = CURRENT_MAKEUP_VARIANT_ITEM + " / " + MAXIMUM_MAKEUP_VARIANT_ITEMS;

		} else if ($type == 'opacity') {

			if (CURRENT_MAKEUP_OPACITY_ITEM == 0) {
				return;
			}

			CURRENT_MAKEUP_OPACITY_ITEM--;

			text = convertSelectorValue(CURRENT_MAKEUP_OPACITY_ITEM) + " / 0.9";

		}

		$(".makeup-currentNumber-" + $category + "-" + $type).text(text);

		$.post("http://tpz_characters/set_makeup_textures", JSON.stringify({
			texture_id: CURRENT_MAKEUP_CATEGORY_ITEM,
			color: CURRENT_MAKEUP_COLOR_PRIMARY_ITEM,
			color2: CURRENT_MAKEUP_COLOR_SECONDARY_ITEM,
			variant: CURRENT_MAKEUP_VARIANT_ITEM,
			opacity: CURRENT_MAKEUP_OPACITY_ITEM,
			type: $type,
		}));

	});

	$("#tpz_characters").on("click", "#makeup-selected-comps-list-next", function () {
		PlayButtonClickSound();

		let $button = $(this);
		let $category = $button.attr('category');
		let $type = $button.attr('type');

		let text;

		if ($type == 'texture_id') {

			if (CURRENT_MAKEUP_CATEGORY_ITEM == MAXIMUM_MAKEUP_CATEGORY_ITEMS) {
				return;
			}

			CURRENT_MAKEUP_CATEGORY_ITEM++;

			text = CURRENT_MAKEUP_CATEGORY_ITEM + " / " + MAXIMUM_MAKEUP_CATEGORY_ITEMS;

		} else if ($type == 'color') {

			if (CURRENT_MAKEUP_COLOR_PRIMARY_ITEM == 10) {
				return;
			}

			CURRENT_MAKEUP_COLOR_PRIMARY_ITEM++;

			text = CURRENT_MAKEUP_COLOR_PRIMARY_ITEM + " / " + 10;

		} else if ($type == 'color2') {

			if (CURRENT_MAKEUP_COLOR_SECONDARY_ITEM == 10) {
				return;
			}

			CURRENT_MAKEUP_COLOR_SECONDARY_ITEM++;

			text = CURRENT_MAKEUP_COLOR_SECONDARY_ITEM + " / " + 10;

		} else if ($type == 'variant') {

			if (CURRENT_MAKEUP_VARIANT_ITEM == MAXIMUM_MAKEUP_VARIANT_ITEMS) {
				return;
			}

			CURRENT_MAKEUP_VARIANT_ITEM++;

			text = CURRENT_MAKEUP_VARIANT_ITEM + " / " + MAXIMUM_MAKEUP_VARIANT_ITEMS;

		} else if ($type == 'opacity') {

			if (CURRENT_MAKEUP_OPACITY_ITEM == 9) {
				return;
			}

			CURRENT_MAKEUP_OPACITY_ITEM++;

			text = convertSelectorValue(CURRENT_MAKEUP_OPACITY_ITEM) + " / 0.9";
		}

		$(".makeup-currentNumber-" + $category + "-" + $type).text(text);

		$.post("http://tpz_characters/set_makeup_textures", JSON.stringify({
			texture_id: CURRENT_MAKEUP_CATEGORY_ITEM,
			color: CURRENT_MAKEUP_COLOR_PRIMARY_ITEM,
			color2: CURRENT_MAKEUP_COLOR_SECONDARY_ITEM,
			variant: CURRENT_MAKEUP_VARIANT_ITEM,
			opacity: CURRENT_MAKEUP_OPACITY_ITEM,
			type: $type,
		}));
	});

});

