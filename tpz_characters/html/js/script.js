
function CloseNUI() {

	$("#tpz_characters").fadeOut();
	$("#categories-list").html('');
	$("#appearance-categories-list").html('');
	$("#lifestyle-categories-list").html('');
	$("#bodyfeatures-categories-list").html('');
	$("#bodyfeatures-selected-comps-list").html('');
	$("#groom-categories-list").html('');
	$("#groom-selected-comps-list").html('');
	$("#makeup-selected-comps-list").html('');

	$.post('http://tpz_characters/close', JSON.stringify({}));
}


$(function () {

	window.addEventListener('message', function (event) {

		var item = event.data;

		if (item.type == "enable") {
			document.body.style.display = item.enable ? "block" : "none";

			$(".main-section").show();
			
			if (item.enable) {

				$("#main-background").hide();
				$("#title").hide();
				$(".main-section").hide();

				$("#tpz_characters").fadeIn(1000);
				$(".sex-dialog").fadeIn(1000);
			}

		} else if (item.action == "set_management_section") {

			item.enable ? $(".management-section").fadeIn() : $(".management-section").fadeOut();

		} else if (item.action == "reset_categories") {

			$("#categories-list").html('');

		} else if (item.action == 'reset_appearance_categories'){

			$("#appearance-categories-list").html('');


		} else if (item.action == 'reset_lifestyle_categories') {

			$("#lifestyle-categories-list").html('');


		} else if (item.action == 'reset_bodyfeatures_categories') {

			$("#bodyfeatures-categories-list").html('');

		} else if (item.action == 'reset_bodyfeatures_components_list'){

			$("#bodyfeatures-selected-comps-list").html('');

		} else if (item.action == 'reset_groom_categories') {

			$("#groom-categories-list").html('');

		} else if (item.action == 'reset_groom_components_list') {

			$("#groom-selected-comps-list").html('');

		} else if (item.action == 'reset_makeup_categories') {

			$("#makeup-categories-list").html('');

		} else if (item.action == 'reset_makeup_components_list') {

			$("#makeup-selected-comps-list").html('');

		} else if (item.action == "display_categories") {

			$(".clothing-categories-section").show();

			$("#info-welcome-text").hide();
			$("#main-clothing-section-button").hide();
			$("#main-accept-button").hide();
			$("#clothing-close-button").hide();

		} else if (item.action == "set_information") {

			$("#title").text(item.title);
			$("#clothing-close-button").text(item.locales['NUI_CLOSE']);
			$("#main-accept-button").text(item.locales['NUI_ACCEPT_OUTFIT']);
			$("#main-identity-section-button").text(item.locales['NUI_IDENTITY']);
			$("#main-facials-section-button").text(item.locales['NUI_FACIALS']);
			$("#main-appearance-section-button").text(item.locales['NUI_APPEARANCE']);
			$("#main-makeup-section-button").text(item.locales['NUI_MAKEUP']);
			$("#main-clothing-section-button").text(item.locales['NUI_OUTFITS']);
			$("#clothing-back-button").text(item.locales['NUI_BACK']);
			$("#clothing-selected-back-button").text(item.locales['NUI_BACK']);
			$("#ageing-back-button").text(item.locales['NUI_BACK']);
			$("#makeup-back-button").text(item.locales['NUI_BACK']);
			$("#lifestyle-back-button").text(item.locales['NUI_BACK']);
			$("#lifestyle-selected-back-button").text(item.locales['NUI_BACK']);
			$("#bodyfeatures-back-button").text(item.locales['NUI_BACK']);
			$("#bodyfeatures-selected-back-button").text(item.locales['NUI_BACK']);
			$("#groom-back-button").text(item.locales['NUI_BACK']);
			$("#groom-selected-back-button").text(item.locales['NUI_BACK']);
			$("#makeup-back-button").text(item.locales['NUI_BACK']);
			$("#makeup-selected-back-button").text(item.locales['NUI_BACK']);
			$("#body-back-button").text(item.locales['NUI_BACK']);
			$("#heritage-back-button").text(item.locales['NUI_BACK']);
			$("#eyes-back-button").text(item.locales['NUI_BACK']);
			$("#clothing-selected-reset-button").text(item.locales['NUI_RESET_OUTFIT_TYPE']);

			$("#clothing-info-text").text(item.locales['NUI_CLOTHING_INFO']);
			$("#clothing-selected-select-tint-button").text(item.locales['NUI_SELECT_TINT']);
			$("#clothing-selected-component-title").text(item.locales['NUI_SELECT_COMPONENT']);
			$("#clothing-selected-palette-title").text(item.locales['NUI_SELECT_PALETTE_TITLE']);

			$("#dialog-title").text(item.locales['DIALOG_TITLE']);
			$("#dialog-save-button").text(item.locales['DIALOG_SAVE_BUTTON']);

			$("#sex-dialog-title").text(item.locales['DIALOG_SEX_TITLE']);
			$("#sex-dialog-info-text").text(item.locales['DIALOG_SEX_DESCRIPTION']);
			$("#sex-dialog-gender-text").text(item.locales['DIALOG_SEX_INPUT_DESCRIPTION']);
			$("#sex-dialog-select-button").text(item.locales['DIALOG_SEX_SELECT_BUTTON']);

			$("#makeup-info-text").text(item.locales['NUI_MAKEUP_INFO']);
			$("#makeup-texture-id-title").text(item.locales['NUI_MAKEUP_TEXTURE_ID']);
			$("#makeup-color1-title").text(item.locales['NUI_MAKEUP_COLOR1']);
			$("#makeup-color2-title").text(item.locales['NUI_MAKEUP_COLOR2']);
			$("#makeup-opacity-title").text(item.locales['NUI_MAKEUP_OPACITY']);

			$("#appearance-info-text").text(item.locales['NUI_APPEARANCE_INFO']);
			$("#appearance-back-button").text(item.locales['NUI_BACK']);
			
			$("#body-info-text").text(item.locales['NUI_BODY_INFO']);
			$("#body-type-title").text(item.locales['NUI_BODY_TYPES']);
			$("#body-waist-title").text(item.locales['NUI_WAIST_TYPES']);
			$("#body-torso-title").text(item.locales['NUI_TORSO_TYPES']);
			$("#body-legs-title").text(item.locales['NUI_LEGS_TYPES']);
			
			$("#ageing-info-text").text(item.locales['NUI_AGEING_INFO']);
			$("#ageing-texture-id-title").text(item.locales['NUI_AGEING_TEXTURE_ID']);
			$("#ageing-opacity-title").text(item.locales['NUI_AGEING_OPACITY']);

			$("#heritage-info-text").text(item.locales['NUI_HERITAGE_INFO']);
			$("#heritage-type-title").text(item.locales['NUI_HERITAGE_TYPES']);
			$("#heritage-color-title").text(item.locales['NUI_HERITAGE_COLORS']);

			$("#lifestyle-texture-id-title").text(item.locales['NUI_LIFESTYLES_TEXTURE_TITLE']);
			$("#lifestyle-opacity-title").text(item.locales['NUI_LIFESTYLES_OPACITY_TITLE']);

			$("#lifestyle-info-text").text(item.locales['NUI_LIFESTYLES_INFO']);

			$("#bodyfeatures-info-text").text(item.locales['NUI_BODYFEATURES_INFO']);
			$("#groom-info-text").text(item.locales['NUI_GROOM_INFO']);
			$("#makeup-info-text").text(item.locales['NUI_MAKEUP_INFO']);

			$("#eyes-info-text").text(item.locales['NUI_EYES_INFO']);
			$("#eyes-texture-id-title").text(item.locales['NUI_EYES_TEXTURE_ID_TITLE']);

		} else if (item.action == 'set_welcome_text'){

			$("#info-welcome-text").text(item.text);

		} else if (item.action == "set_texture_information") {

			/* BODY TYPES */

			MAX_BODY_TYPES = item.max_overlays_info.body_types;
			$("#body-type-currentNumber").text('1 / ' + MAX_BODY_TYPES);

			MAX_BODY_WAIST_TYPES = item.max_overlays_info.waist;
			$("#body-waist-currentNumber").text('1 / ' + MAX_BODY_WAIST_TYPES);

			MAX_BODY_TORSO_TYPES = item.max_overlays_info.torso;
			$("#body-torso-currentNumber").text('1 / ' + MAX_BODY_TORSO_TYPES);

			MAX_BODY_LEGS_TYPES = item.max_overlays_info.legs;
			$("#body-legs-currentNumber").text('1 / ' + MAX_BODY_LEGS_TYPES);

			/* HERITAGE */

			MAX_HERITAGE_TYPES = item.max_overlays_info.heritage_types;
			$("#heritage-type-currentNumber").text('1 / ' + MAX_HERITAGE_TYPES);

			MAX_HERITAGE_COLOR_TYPES = item.max_overlays_info.heritage_color_types;
			$("#heritage-color-currentNumber").text('1 / ' + MAX_HERITAGE_COLOR_TYPES);


			/* AGEING */

			MAX_OVERLAYS_INFO_AGEING_TEXTURE_ID = item.max_overlays_info.ageing;

			$("#ageing-texture-id-currentNumber").text('0 / ' + MAX_OVERLAYS_INFO_AGEING_TEXTURE_ID);
			$("#ageing-opacity-currentNumber").text('1.0 / 1.0');

		} else if (item.action == 'setHeritageMaxColorTypes'){

			MAX_HERITAGE_COLOR_TYPES = item.max;
			$("#heritage-color-currentNumber").text('1 / ' + MAX_HERITAGE_COLOR_TYPES);

		} else if (item.action == "insertCategory") {

			let res = item.result;

			$("#categories-list").append(
				`<div id="categories-list-name" title = "` + res.label + `" category = "` + res.category + `" >` + res.label + `</div>` +
				`<div> &nbsp; </div>`
			);

		} else if (item.action == 'selectedCategory') {

			let res = item.result;
			let max = Number(res.max);

			CURRENT_CLOTHING_CATEGORY_ITEM = res.current;
			MAXIMUM_CLOTHING_CATEGORY_ITEMS = max;

			$("#currentNumber").text(res.current + ' / ' + max);

			$("#clothing-selected-title").text(res.title);
			$("#clothing-selected-info-text").text(res.description);

		} else if (item.action == "insertAppearanceCategory") {

			let res = item.result;

			$("#appearance-categories-list").append(
				`<div id="appearance-categories-list-name" title = "` + res.label + `" category = "` + res.category + `" >` + res.label + `</div>` +
				`<div> &nbsp; </div>`
			);

		} else if (item.action == "insertLifestyleCategory") {

			let res = item.result;

			$("#lifestyle-categories-list").append(
				`<div id="lifestyle-categories-list-name" title = "` + res.label + `" category = "` + res.category + `" >` + res.label + `</div>` +
				`<div> &nbsp; </div>`
			);


		} else if (item.action == 'selectedLifestyleCategory') {

			let res = item.result;
			let max = Number(res.max);

			CURRENT_LIFESTYLE_CATEGORY_ITEM = res.current;
			CURRENT_LIFESTYLE_CATEGORY_ITEM_OPACITY = res.current_opacity;

			MAXIMUM_LIFESTYLE_CATEGORY_ITEMS = max;

			$("#lifestyle-texture-id-currentNumber").text(res.current + ' / ' + max);

			let opacity = res.current_opacity >= 1 ? "1.0" : res.current_opacity;

			$("#lifestyle-opacity-currentNumber").text(opacity + ' / 1.0');

			$("#lifestyle-selected-title").text(res.title);
			$("#lifestyle-selected-info-text").text(res.description);

		} else if (item.action == "insertBodyFeaturesCategoryElements") {

			let res = item.result;
			$("#bodyfeatures-selected-comps-list").append(
				`<div class="bodyfeatures-selected-comps-list-title">${res.label}</div>
				<div class="bodyfeatures-selected-comps-list-selector">
				  <div class="bodyfeatures-selected-comps-list-nav-container">
					<button id="bodyfeatures-selected-comps-list-prev" class = "bodyfeatures-${res.category}" category ="${res.category}">⟨</button>
					<div id="bodyfeatures-selected-comps-list-currentNumberMin">-1.0</div>
					<div id="bodyfeatures-selected-comps-list-currentNumber" class = "bodyfeatures-currentNumber-${res.category}" >${res.current}</div>
					<div id="bodyfeatures-selected-comps-list-currentNumberMax">1.0</div>
					<button id="bodyfeatures-selected-comps-list-next" class = "bodyfeatures-${res.category}" category ="${res.category}">⟩</button>
				  </div>
				</div>`
			  );

		} else if (item.action == 'selectedBodyFeaturesCategory') {

			let res = item.result;
			$("#bodyfeatures-selected-title").text(res.title);
			$("#bodyfeatures-selected-info-text").text(res.description);

			$(".bodyfeatures-selected-section").fadeIn();

			let margin = res.max > 3 ? 80.1 : 79.9;

			$("#bodyfeatures-selected-comps-list").css('left', margin + "vw");


		} else if (item.action == 'insertBodyFeaturesCategory'){
			let res = item.result;
			$("#bodyfeatures-categories-list").append(
				`<div id="bodyfeatures-categories-list-name" title = "` + res.label + `" category = "` + res.category + `" >` + res.label + `</div>` +
				`<div> &nbsp; </div>`
			);

		} else if (item.action == 'insertGroomCategory') {
			let res = item.result;

			$("#groom-categories-list").append(
				`<div id="groom-categories-list-name" title = "` + res.label + `" category = "` + res.category + `" >` + res.label + `</div>` +
				`<div> &nbsp; </div>`
			);

		} else if (item.action == "insertGroomCategoryElements") {

			let res = item.result;

			let current = res.current;
			let max = res.max

			if (res.category == 'hair' || res.category == 'beard' || res.category == 'bow') {
				$("#groom-selected-comps-list").css('top', '38.3%');

			} else {

				if (res.type == 'opacity'){

					if (current == 10 || current == 1.0 ){
						current = "1.0";
					}

					if (current == 0.0){
						current = "0.0";
					}

					max = "1.0";
				}

				$("#groom-selected-comps-list").css('top', '30.5%');
			}

			$("#groom-selected-comps-list").append(
				`<div class="groom-selected-comps-list-title">${res.label}</div>
				<div class="groom-selected-comps-list-selector">
				  <div class="groom-selected-comps-list-nav-container">
					<button id="groom-selected-comps-list-prev" category ="${res.category}" type ="${res.type}">⟨</button>
					<div id="groom-selected-comps-list-currentNumber" class = "groom-currentNumber-${res.category}-${res.type}" >${current} / ${max}</div>
					<button id="groom-selected-comps-list-next" category ="${res.category}" type ="${res.type}">⟩</button>
				  </div>
				</div>`
			);

		} else if (item.action == 'selectedGroomCategory') {

			let res = item.result;
			$("#groom-selected-title").text(res.title);
			$("#groom-selected-info-text").text(res.description);

			$(".groom-selected-section").fadeIn();

			let margin = res.max > 3 ? 80.1 : 79.9;

			$("#groom-selected-comps-list").css('left', margin + "vw");

			CURRENT_GROOM_CATEGORY_ITEM  = res.current_texture_id;
			MAXIMUM_GROOM_CATEGORY_ITEMS = res.max_texture_id;

			CURRENT_GROOM_COLOR_ITEM     = res.current_color;
			MAXIMUM_GROOM_COLOR_ITEMS    = res.max_colors;

			let opacity = res.current_opacity != 10 ? convertToInt(res.current_opacity) : 10;
			CURRENT_GROOM_OPACITY_ITEM = opacity;

		} else if (item.action == 'selectedEyesCategory') {

			$("#eyes-texture-id-currentNumber").text(item.current + " / " + item.max);

			MAX_OVERLAYS_INFO_EYES_TEXTURE_ID = item.max;
			
		} else if (item.action == 'updateGroomSpecificData') {

			MAXIMUM_GROOM_COLOR_ITEMS = item.max_colors;
			$(".groom-currentNumber-" + item.category + "-color").text("1 / " + item.max_colors);
			$(".groom-currentNumber-" + item.category + "-opacity").text("1.0 / 1.0");

		} else if (item.action == 'insertMakeupCategory') {
			let res = item.result;

			$("#makeup-categories-list").append(
				`<div id="makeup-categories-list-name" title = "` + res.label + `" category = "` + res.category + `" >` + res.label + `</div>` +
				`<div> &nbsp; </div>`
			);

		} else if (item.action == "insertMakeupCategoryElements") {

			let res = item.result;

			let current = res.current;
			let max = res.max

			if (res.category == 'hair' || res.category == 'beard' || res.category == 'bow') {
				$("#makeup-selected-comps-list").css('top', '38.3%');

			} else {

				if (res.type == 'opacity') {

					if (current == 9 || current == 1.0) {
						current = "0.9";
					}

					if (current == 0.0) {
						current = "0.0";
					}

					max = "0.9";
				}

				$("#makeup-selected-comps-list").css('top', '30.5%');
			}

			$("#makeup-selected-comps-list").append(
				`<div class="makeup-selected-comps-list-title">${res.label}</div>
				<div class="makeup-selected-comps-list-selector">
				  <div class="makeup-selected-comps-list-nav-container">
					<button id="makeup-selected-comps-list-prev" category ="${res.category}" type ="${res.type}">⟨</button>
					<div id="makeup-selected-comps-list-currentNumber" class = "makeup-currentNumber-${res.category}-${res.type}" >${current} / ${max}</div>
					<button id="makeup-selected-comps-list-next" category ="${res.category}" type ="${res.type}">⟩</button>
				  </div>
				</div>`
			);

		} else if (item.action == 'selectedMakeupCategory') {

			let res = item.result;
			$("#makeup-selected-title").text(res.title);
			$("#makeup-selected-info-text").text(res.description);

			$(".makeup-selected-section").fadeIn();

			let margin = res.max > 3 ? 80.1 : 79.9;

			$("#makeup-selected-comps-list").css('left', margin + "vw");

			CURRENT_MAKEUP_CATEGORY_ITEM = res.current_texture_id;
			MAXIMUM_MAKEUP_CATEGORY_ITEMS = res.max_texture_id;

			CURRENT_MAKEUP_COLOR_PRIMARY_ITEM = res.primary_color;
			CURRENT_MAKEUP_COLOR_SECONDARY_ITEM = res.secondary_color;

			CURRENT_MAKEUP_VARIANT_ITEM  = res.current_variant;
			MAXIMUM_MAKEUP_VARIANT_ITEMS = res.max_variants;

			let opacity = res.current_opacity != 9 ? convertToInt(res.current_opacity) : 9;
			CURRENT_MAKEUP_OPACITY_ITEM = opacity;


		} else if (item.action == 'setOutfitComponentInformation') {

			$("#palette-currentNumber").text(item.current + ' / ' + item.max);

			SELECTED_ITEM_PALETTE_ID       = item.current;
			SELECTED_ITEM_MAXIMUM_PALETTES = item.max;

			$('.r-num, .r-range').val(item.tint0);
			$('.g-num, .g-range').val(item.tint1);
			$('.b-num, .b-range').val(item.tint2);

		} else if (item.action == "sendNotification") {
			let prod_notify = item.notification_data;
			SendNotification(prod_notify.message, prod_notify.color, prod_notify.duration);

		} else if (item.action == "close") {
			CloseNUI();
		}

		(function () {
			const rNum = document.querySelector('.r-num');
			const gNum = document.querySelector('.g-num');
			const bNum = document.querySelector('.b-num');
			const rRange = document.querySelector('.r-range');
			const gRange = document.querySelector('.g-range');
			const bRange = document.querySelector('.b-range');

			function updatePreview() {
				const r = parseInt(rNum.value) || 0;
				const g = parseInt(gNum.value) || 0;
				const b = parseInt(bNum.value) || 0;
				rRange.value = r; gRange.value = g; bRange.value = b;

				SELECTED_ITEM_TINT1 = r;
				SELECTED_ITEM_TINT2 = g;
				SELECTED_ITEM_TINT3 = b;
			}

			[rNum, gNum, bNum].forEach(el => {
				el.addEventListener('input', updatePreview);
			});

			rRange.addEventListener('input', () => { rNum.value = rRange.value; updatePreview(); });
			gRange.addEventListener('input', () => { gNum.value = gRange.value; updatePreview(); });
			bRange.addEventListener('input', () => { bNum.value = bRange.value; updatePreview(); });


			updatePreview();
		})();
	});

	$(document).keydown(function (e) {

		if (!$(".info").is(":visible") || $(".sex-dialog").is(":visible") || $(".dialog").is(":visible")) {
			return;
		}
		
		switch (e.key) {
			case "PageUp":

				$.post('http://tpz_characters/key_action', JSON.stringify({ action: "ZOOM_IN"}));
				break;
			case "PageDown":
				$.post('http://tpz_characters/key_action', JSON.stringify({ action: "ZOOM_OUT" }));
				break;
			case "ArrowUp":
				$.post('http://tpz_characters/key_action', JSON.stringify({ action: "UP_CAMERA" }));
				break;
			case "ArrowDown":
				$.post('http://tpz_characters/key_action', JSON.stringify({ action: "DOWN_CAMERA" }));
				break;
			case "ArrowLeft":
				$.post('http://tpz_characters/key_action', JSON.stringify({ action: "ROTATE_LEFT" }));
				break;
			case "ArrowRight":
				$.post('http://tpz_characters/key_action', JSON.stringify({ action: "ROTATE_RIGHT" }));
				break;

			case "Tab":
				$.post('http://tpz_characters/key_action', JSON.stringify({ action: "DRESSING" }));
				break;

			case "x":
				$.post('http://tpz_characters/key_action', JSON.stringify({ action: "HANDS_UP_DOWN" }));
				break;

			case "X":
				$.post('http://tpz_characters/key_action', JSON.stringify({ action: "HANDS_UP_DOWN" }));
				break;
		}
	});
	
	$("#tpz_characters").on("click", "#main-identity-section-button", function () {
		PlayButtonClickSound();

		$(".dialog").fadeIn();
	});

	$("#tpz_characters").on("click", "#dialog-save-button", function() {
		PlayButtonClickSound();

		// Verify date
		var date = $("#dialog-dob-date-input").val();

		if (date == null || date == false || date == "" || !date || date == undefined) {
			RequestNotification("INVALID_DATE_OF_BIRTH", "error", 4000);
			return;
		}

		if (isInvalidDate(date)){
			RequestNotification("INVALID_DATE_OF_BIRTH", "error", 4000);
			return;
		}

		var firstname = $("#dialog-firstname-input").val();
		var lastname = $("#dialog-lastname-input").val();

		if (firstname == null || firstname == "" || firstname == " " || lastname == null || lastname == "" || lastname == " ") {
			RequestNotification("INVALID_FIRSTNAME_OR_LASTNAME", "error", 4000);
			return;
		}

		var formattedDate = reformatDate(date);

		$.post('http://tpz_characters/save_identity', JSON.stringify({
			firstname: firstname,
			lastname: lastname,
			dob: formattedDate,
			//sex: $("input[type='radio'][name='sex']:checked").val(),
		}));

		$(".dialog").fadeOut();

	});
	

	$("#tpz_characters").on("click", "#sex-dialog-select-button", function () {
		PlayButtonClickSound();

		var sex = $('input[name="gender"]:checked').val();

		if (sex == null || sex == false || sex == "" || !sex || sex == undefined) {
			RequestNotification("INVALID_SEX_INPUT", "error", 4000);
			return;
		}

		sex = sex.toUpperCase();

		if (sex != 'FEMALE' && sex != 'MALE') {
			RequestNotification("INVALID_SEX_INPUT", "error", 4000);
			return;
		}

		$.post('http://tpz_characters/select_sex', JSON.stringify({ sex: sex }));

		$(".sex-dialog").fadeOut();

		setTimeout(() => {
			$("#main-background").fadeIn();
			$("#title").fadeIn();
			$(".main-section").fadeIn();
			$(".info").fadeIn();
		}, 12000); // 5000ms = 5 seconds
	});

	$("#tpz_characters").on("click", "#main-appearance-section-button", function () {
		PlayButtonClickSound();

		$(".main-section").fadeOut();
		$(".appearance-section").fadeIn();


	});

	$("#tpz_characters").on("click", "#main-makeup-section-button", function () {
		PlayButtonClickSound();

		$(".main-section").fadeOut();
		$(".makeup-section").fadeIn();


	});

	$("#tpz_characters").on("click", "#main-accept-button", function () {
		PlayButtonClickSound();

		$.post('http://tpz_characters/create', JSON.stringify({}));
	});

});

