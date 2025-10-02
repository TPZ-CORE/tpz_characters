

$(function () {


	$("#tpz_characters").on("click", "#lifestyle-back-button", function () {
		PlayButtonClickSound();

		$(".lifestyle-section").hide();
		$(".appearance-section").show();
	});


	$("#tpz_characters").on("click", "#lifestyle-categories-list-name", function () {
		PlayButtonClickSound();

		let $button = $(this);
		let $category = $button.attr('category');
		let $title = $button.attr('title');

		$.post("http://tpz_characters/request_lifestyle_category_data", JSON.stringify({ category: $category, title: $title }));

		$(".lifestyle-section").hide();
		$(".lifestyle-selected-section").show();

	});


	$("#tpz_characters").on("click", "#lifestyle-selected-back-button", function () {
		PlayButtonClickSound();

		$(".lifestyle-selected-section").hide();
		$(".lifestyle-section").show();

	});

	$("#tpz_characters").on("click", "#appearance-categories-list-name", function () {

		let $button = $(this);
		let $section = $button.attr('category');

		if ($section != '.lifestyle-section') {
			return;
		}

		$.post('http://tpz_characters/request_lifestyle_categories', JSON.stringify({}));

		$(".appearance-section").fadeOut();
		$($section).fadeIn();

	});


	$("#tpz_characters").on("click", "#lifestyle-categories-list-name", function () {

		let $button = $(this);
		let $category = $button.attr('category');
		let $title = $button.attr('title');

		$.post('http://tpz_characters/request_selected_lifestyle_data', JSON.stringify({ 
			category: $category,
			title : $title,
		}));

		$(".lifestyle-section").fadeOut();
		$(".lifestyle-selected-section").fadeIn();

	});


	// texture-id adjusters.
	$("#tpz_characters").on("click", "#lifestyle-texture-id-prev", function () {
		PlayButtonClickSound();

		CURRENT_LIFESTYLE_CATEGORY_ITEM--;

		if (CURRENT_LIFESTYLE_CATEGORY_ITEM < 0) {
			CURRENT_LIFESTYLE_CATEGORY_ITEM = MAXIMUM_LIFESTYLE_CATEGORY_ITEMS;
		}

		CURRENT_LIFESTYLE_CATEGORY_ITEM_OPACITY = 10;
		$("#lifestyle-opacity-currentNumber").text("1.0 / 1.0");

		$("#lifestyle-texture-id-currentNumber").text(CURRENT_LIFESTYLE_CATEGORY_ITEM + " / " + MAXIMUM_LIFESTYLE_CATEGORY_ITEMS);

		$.post("http://tpz_characters/set_lifestyle_textures", JSON.stringify({
			texture_id: CURRENT_LIFESTYLE_CATEGORY_ITEM,
			opacity: CURRENT_LIFESTYLE_CATEGORY_ITEM_OPACITY,
		}));

	});

	$("#tpz_characters").on("click", "#lifestyle-texture-id-next", function () {
		PlayButtonClickSound();

		CURRENT_LIFESTYLE_CATEGORY_ITEM++;

		if (CURRENT_LIFESTYLE_CATEGORY_ITEM > MAXIMUM_LIFESTYLE_CATEGORY_ITEMS) {
			CURRENT_LIFESTYLE_CATEGORY_ITEM = 0;
		}

		CURRENT_LIFESTYLE_CATEGORY_ITEM_OPACITY = 10;
		$("#lifestyle-opacity-currentNumber").text("1.0 / 1.0");

		$("#lifestyle-texture-id-currentNumber").text(CURRENT_LIFESTYLE_CATEGORY_ITEM + " / " + MAXIMUM_LIFESTYLE_CATEGORY_ITEMS);

		$.post("http://tpz_characters/set_lifestyle_textures", JSON.stringify({
			texture_id: CURRENT_LIFESTYLE_CATEGORY_ITEM,
			opacity: CURRENT_LIFESTYLE_CATEGORY_ITEM_OPACITY,
		}));
	});

	// opacity adjusters.
	$("#tpz_characters").on("click", "#lifestyle-opacity-prev", function () {
		PlayButtonClickSound();

		CURRENT_LIFESTYLE_CATEGORY_ITEM_OPACITY--;

		if (CURRENT_LIFESTYLE_CATEGORY_ITEM_OPACITY <= 0) {
			CURRENT_LIFESTYLE_CATEGORY_ITEM_OPACITY = 0;
		}

		let opacity_text = convertSelectorValue(CURRENT_LIFESTYLE_CATEGORY_ITEM_OPACITY);
		$("#lifestyle-opacity-currentNumber").text(opacity_text + " / 1.0");

		$.post("http://tpz_characters/set_lifestyle_textures", JSON.stringify({
			texture_id: CURRENT_LIFESTYLE_CATEGORY_ITEM,
			opacity: CURRENT_LIFESTYLE_CATEGORY_ITEM_OPACITY,
		}));

	});

	$("#tpz_characters").on("click", "#lifestyle-opacity-next", function () {
		PlayButtonClickSound();

		CURRENT_LIFESTYLE_CATEGORY_ITEM_OPACITY++;

		if (CURRENT_LIFESTYLE_CATEGORY_ITEM_OPACITY >= 10) {
			CURRENT_LIFESTYLE_CATEGORY_ITEM_OPACITY = 10;
		}

		let opacity_text = convertSelectorValue(CURRENT_LIFESTYLE_CATEGORY_ITEM_OPACITY);
		$("#lifestyle-opacity-currentNumber").text(opacity_text + " / 1.0");

		$.post("http://tpz_characters/set_lifestyle_textures", JSON.stringify({
			texture_id: CURRENT_LIFESTYLE_CATEGORY_ITEM,
			opacity: CURRENT_LIFESTYLE_CATEGORY_ITEM_OPACITY,
		}));
	});

});

