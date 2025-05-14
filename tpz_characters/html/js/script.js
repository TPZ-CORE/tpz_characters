$(function() {
	window.addEventListener('message', function(event) {

		if (event.data.type == "enableui") {

			document.body.style.display = event.data.enable ? "block" : "none";

			if (event.data.enable) {
				$("#tpz_characters").fadeIn(2000);
			}

		}
		
	});

	$("#tpz_characters").on("click", "#create_character_button", function() {
		playAudio("button_click.wav");

		// Verify date
		var date      = $("#character_create_dob").val();
		var dateCheck = new Date($("#character_create_dob").val());

		if (date == null || date == "" || date == " " || dateCheck == "Invalid Date") {
			date == "invalid";
		}

		var firstname = $("#character_create_firstname").val();
		var lastname  = $("#character_create_lastname").val();

		if (firstname == null || firstname == "" || firstname == " " || lastname == null || lastname == "" || lastname == " ") {
			return;
		}

		$.post('http://tpz_characters/submit', JSON.stringify({
			firstname: firstname,
			lastname: lastname,
			dateofbirth: date,
			sex: $("input[type='radio'][name='sex']:checked").val(),
		}));

	});

	$("#tpz_characters").on("click", "#create_character_cancel_button", function() {
		playAudio("button_click.wav");

		$("#tpz_characters").fadeOut(2000);
		$.post('http://tpz_characters/close', JSON.stringify({ }));
	});

});

const loadScript = (FILE_URL, async = true, type = "text/javascript") => {
	return new Promise((resolve, reject) => {
		try {
			const scriptEle = document.createElement("script");
			scriptEle.type = type;
			scriptEle.async = async;
			scriptEle.src =FILE_URL;
  
			scriptEle.addEventListener("load", (ev) => {
				resolve({ status: true });
			});
  
			scriptEle.addEventListener("error", (ev) => {
				reject({
					status: false,
					message: `Failed to load the script ${FILE_URL}`
				});
			});
  
			document.body.appendChild(scriptEle);
		} catch (error) {
			reject(error);
		}
	});
  };
  
  loadScript("js/locales/locales-" + Config.Locale + ".js").then( data  => { 

	displayPage("main", "visible");
	$("#tpz_characters").fadeOut();

	$("#character_create_title").text(Locales.CREATE_CHARACTER_TITLE);
	$("#character_create_sex_select_m_text").text(Locales.RADIO_MALE);
	$("#character_create_sex_select_f_text").text(Locales.RADIO_FEMALE);

	$("#create_character_button").text(Locales.CHARACTER_CREATE_BUTTON);
	$("#create_character_cancel_button").text(Locales.CHARACTER_CANCEL_BUTTON);

  }) .catch( err => { console.error(err); });

function displayPage(page, cb){
	document.getElementsByClassName(page)[0].style.visibility = cb;
  
	[].forEach.call(document.querySelectorAll('.' + page), function (el) {
	  el.style.visibility = cb;
	});
}

function playAudio(sound) {
	var audio = new Audio('./audio/' + sound);
	audio.volume = Config.DefaultClickSoundVolume;
	audio.play();
}
