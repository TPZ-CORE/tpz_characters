

$(function () {


	$("#tpz_characters").on("click", "#clothing-back-button", function () {
		PlayButtonClickSound();

		$(".main-section").show();
		$("#info-welcome-text").show();

		$(".clothing-categories-section").hide();

		$("#clothing-info-text").show();
		$("#main-clothing-section-button").show();
		$("#main-accept-button").show();
		$("#clothing-close-button").show();
	});


	$("#tpz_characters").on("click", "#categories-list-name", function () {
		PlayButtonClickSound();

		let $button = $(this);
		let $category = $button.attr('category');
		let $title = $button.attr('title');

		$.post("http://tpz_characters/request_category_data", JSON.stringify({ category: $category, title: $title }));

		$(".clothing-categories-section").hide();
		$(".clothing-selected-section").show();

	});


	$("#tpz_characters").on("click", "#clothing-selected-back-button", function () {
		PlayButtonClickSound();

		$(".clothing-selected-section").hide();
		$(".clothing-categories-section").show();


	});

	$("#tpz_characters").on("click", "#main-clothing-section-button", function () {
		PlayButtonClickSound();
		$(".main-section").hide();

		$.post('http://tpz_characters/request_clothing_categories', JSON.stringify({}));
	});


	$("#tpz_characters").on("click", "#prev", function () {
		PlayButtonClickSound();

		CURRENT_CLOTHING_CATEGORY_ITEM--;

		if (CURRENT_CLOTHING_CATEGORY_ITEM < 0) {
			CURRENT_CLOTHING_CATEGORY_ITEM = MAXIMUM_CLOTHING_CATEGORY_ITEMS;
		}

		SELECTED_ITEM_PALETTE_ID = 1;

		$("#currentNumber").text(CURRENT_CLOTHING_CATEGORY_ITEM + " / " + MAXIMUM_CLOTHING_CATEGORY_ITEMS);

		$.post("http://tpz_characters/load_selected_cloth", JSON.stringify({
			id: CURRENT_CLOTHING_CATEGORY_ITEM,
			palette: 1,
			tint0: 0, 
			tint1: 0, 
			tint2: 0,
			actionType: 'COMPONENT',
		}));

	});

	$("#tpz_characters").on("click", "#next", function () {
		PlayButtonClickSound();

		CURRENT_CLOTHING_CATEGORY_ITEM++;

		if (CURRENT_CLOTHING_CATEGORY_ITEM > MAXIMUM_CLOTHING_CATEGORY_ITEMS) {
			CURRENT_CLOTHING_CATEGORY_ITEM = 0;
		}

		SELECTED_ITEM_PALETTE_ID = 1;

		$("#currentNumber").text(CURRENT_CLOTHING_CATEGORY_ITEM + " / " + MAXIMUM_CLOTHING_CATEGORY_ITEMS);

		$.post("http://tpz_characters/load_selected_cloth", JSON.stringify({
			id: CURRENT_CLOTHING_CATEGORY_ITEM,
			palette: 1,
			tint0: 0,
			tint1: 0, 
			tint2: 0,
			actionType: 'COMPONENT',
		}));
	});

	$("#tpz_characters").on("click", "#palette-prev", function () {
		PlayButtonClickSound();

		SELECTED_ITEM_PALETTE_ID--;

		if (SELECTED_ITEM_PALETTE_ID < 1) {
			SELECTED_ITEM_PALETTE_ID = SELECTED_ITEM_MAXIMUM_PALETTES;
		}

		$("#palette-currentNumber").text(SELECTED_ITEM_PALETTE_ID + " / " + SELECTED_ITEM_MAXIMUM_PALETTES);

		$.post("http://tpz_characters/load_selected_cloth", JSON.stringify({
			id: CURRENT_CLOTHING_CATEGORY_ITEM,
			palette: SELECTED_ITEM_PALETTE_ID,
			tint0: 0,
			tint1: 0, 
			tint2: 0,
			actionType: 'PALETTE',
		}));

	});

	$("#tpz_characters").on("click", "#palette-next", function () {
		PlayButtonClickSound();

		SELECTED_ITEM_PALETTE_ID++;

		if (SELECTED_ITEM_PALETTE_ID > SELECTED_ITEM_MAXIMUM_PALETTES) {
			SELECTED_ITEM_PALETTE_ID = 1;
		}

		$("#palette-currentNumber").text(SELECTED_ITEM_PALETTE_ID + " / " + SELECTED_ITEM_MAXIMUM_PALETTES);

		$.post("http://tpz_characters/load_selected_cloth", JSON.stringify({
			id: CURRENT_CLOTHING_CATEGORY_ITEM,
			palette: SELECTED_ITEM_PALETTE_ID,
			tint0: 0, 
			tint1: 0, 
			tint2: 0,
			actionType: 'PALETTE',
		}));
	});

	$("#tpz_characters").on("click", "#clothing-selected-select-tint-button", function () {
		PlayButtonClickSound();

		$.post("http://tpz_characters/load_selected_cloth", JSON.stringify({
			id: CURRENT_CLOTHING_CATEGORY_ITEM,
			palette: SELECTED_ITEM_PALETTE_ID,
			tint0: SELECTED_ITEM_TINT1, 
			tint1: SELECTED_ITEM_TINT2, 
			tint2: SELECTED_ITEM_TINT3,
			actionType: 'TINT',
		}));

	});


});

