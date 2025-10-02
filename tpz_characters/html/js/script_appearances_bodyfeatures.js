

$(function () {


	$("#tpz_characters").on("click", "#bodyfeatures-back-button", function () {
		PlayButtonClickSound();

		$(".bodyfeatures-section").hide();
		$(".appearance-section").show();
	});


	$("#tpz_characters").on("click", "#bodyfeatures-categories-list-name", function () {
		PlayButtonClickSound();

		let $button = $(this);
		let $category = $button.attr('category');
		let $title = $button.attr('title');

		$.post("http://tpz_characters/request_bodyfeatures_category_data", JSON.stringify({ category: $category, title: $title }));

		$(".bodyfeatures-section").hide();
		$(".bodyfeatures-selected-section").show();

	});


	$("#tpz_characters").on("click", "#bodyfeatures-selected-back-button", function () {
		PlayButtonClickSound();

		$(".bodyfeatures-selected-section").hide();
		$(".bodyfeatures-section").show();

	});

	$("#tpz_characters").on("click", "#appearance-categories-list-name", function () {

		let $button = $(this);
		let $section = $button.attr('category');

		if ($section != '.bodyfeatures-section') {
			return;
		}

		$.post('http://tpz_characters/request_bodyfeatures_categories', JSON.stringify({}));

		$(".appearance-section").fadeOut();
		$($section).fadeIn();

	});


	$("#tpz_characters").on("click", "#bodyfeatures-categories-list-name", function () {

		let $button = $(this);
		let $category = $button.attr('category');
		let $title = $button.attr('title');

		$.post('http://tpz_characters/request_selected_bodyfeatures_data', JSON.stringify({ 
			category: $category,
			title : $title,
		}));

		$(".bodyfeatures-section").fadeOut();

	});

	$("#tpz_characters").on("click", "#bodyfeatures-selected-comps-list-prev", function () {
		PlayButtonClickSound();

		let $button = $(this);
		let $category = $button.attr('category');
		let $val = $(".bodyfeatures-currentNumber-" + $category).text();

		console.log($val)
		$val = Number($val);

		$val = $val - 0.1;
		$val = $val.toFixed(1);

		if ($val <= -1.0) { 
			$val = "-1.0"; 

		} else if ($val == 0.0) {
			$val = "0";
		}

		$(".bodyfeatures-currentNumber-" + $category).text($val);

		$.post("http://tpz_characters/set_bodyfeatures_textures", JSON.stringify({
			category: $category,
			value: $val,
		}));

	});

	$("#tpz_characters").on("click", "#bodyfeatures-selected-comps-list-next", function () {
		PlayButtonClickSound();

		let $button = $(this);
		let $category = $button.attr('category');
		let $val      = $(".bodyfeatures-currentNumber-" + $category).text();

		console.log($val)
		$val = Number($val);

		$val = $val + 0.1;
		$val = $val.toFixed(1);

		if ($val >= 1.0){ 
			$val = "1.0"; 

		}else if ($val == 0.0){
			$val = "0";
		}

		$(".bodyfeatures-currentNumber-" + $category).text($val);
	
		$.post("http://tpz_characters/set_bodyfeatures_textures", JSON.stringify({
			category: $category,
			value: $val,
		}));

	});


});

