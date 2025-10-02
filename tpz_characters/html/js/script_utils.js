let CURRENT_CLOTHING_CATEGORY_ITEM  = 1;
let MAXIMUM_CLOTHING_CATEGORY_ITEMS = 0;
let SELECTED_ITEM_TINT1             = 0;
let SELECTED_ITEM_TINT2             = 0;
let SELECTED_ITEM_TINT3             = 0;
let SELECTED_ITEM_PALETTE_ID        = 1;
let SELECTED_ITEM_MAXIMUM_PALETTES  = 1;

let CURRENT_OVERLAY_INFO_AGEING_TEXTURE_ID  = 0;
let MAX_OVERLAYS_INFO_AGEING_TEXTURE_ID     = 0;

let CURRENT_OVERLAY_INFO_AGEING_OPACITY     = 10;
let MAX_OVERLAYS_INFO_AGEING_OPACITY        = 10;

let CURRENT_BODY_TYPE                       = 1;
let MAX_BODY_TYPES                          = 1;
let CURRENT_BODY_WAIST_TYPE                 = 1;
let MAX_BODY_WAIST_TYPES                    = 1;
let CURRENT_BODY_TORSO_TYPE                 = 1;
let MAX_BODY_TORSO_TYPES                    = 1;
let CURRENT_BODY_LEGS_TYPE                  = 1;
let MAX_BODY_LEGS_TYPES                     = 1;

let CURRENT_HERITAGE_TYPE                   = 1;
let MAX_HERITAGE_TYPES                      = 1;
let CURRENT_HERITAGE_COLOR_TYPE             = 1;
let MAX_HERITAGE_COLOR_TYPES                = 1;

let CURRENT_LIFESTYLE_CATEGORY_ITEM         = 0;
let CURRENT_LIFESTYLE_CATEGORY_ITEM_OPACITY = 0;
let MAXIMUM_LIFESTYLE_CATEGORY_ITEMS        = 0;

let CURRENT_GROOM_CATEGORY_ITEM            = 1;
let MAXIMUM_GROOM_CATEGORY_ITEMS           = 1;

let CURRENT_GROOM_COLOR_ITEM               = 1;
let MAXIMUM_GROOM_COLOR_ITEMS              = 1;

let CURRENT_GROOM_OPACITY_ITEM             = 10;

let CURRENT_MAKEUP_CATEGORY_ITEM           = 0;
let MAXIMUM_MAKEUP_CATEGORY_ITEMS          = 1;

let CURRENT_MAKEUP_COLOR_PRIMARY_ITEM      = 0;
let CURRENT_MAKEUP_COLOR_SECONDARY_ITEM    = 0;

let CURRENT_MAKEUP_VARIANT_ITEM            = 0;
let MAXIMUM_MAKEUP_VARIANT_ITEMS           = 0;

let CURRENT_MAKEUP_OPACITY_ITEM            = 9;


document.addEventListener("DOMContentLoaded", function () {

  $("#main").fadeOut();

  displayPage("info", "visible");
  $(".info").fadeOut();

  displayPage("sex-dialog", "visible");
  $(".sex-dialog").fadeOut();

  displayPage("dialog", "visible");
  $(".dialog").fadeOut();

  displayPage("main-section", "visible");
  $(".main-section").fadeOut();

  displayPage("appearance-section", "visible");
  $(".appearance-section").fadeOut();

  displayPage("body-section", "visible");
  $(".body-section").fadeOut();

  displayPage("heritage-section", "visible");
  $(".heritage-section").fadeOut();

  displayPage("groom-section", "visible");
  $(".groom-section").fadeOut();

  displayPage("ageing-section", "visible");
  $(".ageing-section").fadeOut();

  displayPage("lifestyle-section", "visible");
  $(".lifestyle-section").fadeOut();

  displayPage("lifestyle-selected-section", "visible");
  $(".lifestyle-selected-section").fadeOut();

  displayPage("bodyfeatures-section", "visible");
  $(".bodyfeatures-section").fadeOut();

  displayPage("bodyfeatures-selected-section", "visible");
  $(".bodyfeatures-selected-section").fadeOut();

  displayPage("groom-section", "visible");
  $(".groom-section").fadeOut();

  displayPage("groom-selected-section", "visible");
  $(".groom-selected-section").fadeOut();

  displayPage("makeup-section", "visible");
  $(".makeup-section").fadeOut();

  displayPage("makeup-selected-section", "visible");
  $(".makeup-selected-section").fadeOut();

  displayPage("clothing-categories-section", "visible");
  $(".clothing-categories-section").fadeOut();

  displayPage("clothing-selected-section", "visible");
  $(".clothing-selected-section").fadeOut();

  displayPage("notification", "visible");
  $(".notification").fadeOut();

});

function PlayButtonClickSound() {
  var audio = new Audio('./audio/button_click.wav');
  audio.volume = 0.3;
  audio.play();
}

function displayPage(page, cb){
  document.getElementsByClassName(page)[0].style.visibility = cb;

  [].forEach.call(document.querySelectorAll('.' + page), function (el) {
    el.style.visibility = cb;
  });
}

function isInvalidDate(dateString) {
  const date = new Date(dateString);
  return isNaN(date.getTime());
}

function reformatDate(dateString) {
  const parts = dateString.split("-");
  if (parts.length !== 3) return "Invalid date format";
  return `${parts[2]}/${parts[1]}/${parts[0]}`;
}


function RequestNotification(text, type, duration) {
  $.post('http://tpz_characters/requestNotification', JSON.stringify({ message: text, messageType: type, duration: duration }));
}

let notificationTimeout; // store timeout globally

function SendNotification(text, color, cooldown) {
  $("#notification_message").text("");
  $("#notification_message").fadeOut();
  
  // Default cooldown
  cooldown = (cooldown == null || cooldown === 0 || cooldown === undefined) ? 4000 : cooldown;

  // Clear any previous timeout
  if (notificationTimeout) {
    clearTimeout(notificationTimeout);
    notificationTimeout = null;
  }

  // Update message
  $("#notification_message").text(text);
  $("#notification_message").css("color", color);
  $("#notification_message").fadeIn();

  // Set new timeout
  notificationTimeout = setTimeout(function () {
    $("#notification_message").text("");
    $("#notification_message").fadeOut();
    notificationTimeout = null; // clear reference
  }, cooldown);
}

function convertSelectorValue(val) {
  if (val < 0 || val > 10) {
    return val;
  }
  const scaled = (val / 10).toFixed(1); // 0.1, 0.2, ..., 1.0
  return `${scaled}`;
}

function convertToInt(val) {
  const num = parseFloat(val); // handle both string and number inputs
  if (num < 0 || num > 1) {
    return val;
  }
  return Math.round(num * 10); // scale back up to integer
}

function isDecimalValue(val) {
  const num = parseFloat(val);

  // Must be a valid number
  if (isNaN(num)) return false;

  // Decimal values should be between 0.0 and 1.0 (inclusive)
  // and not equal to an integer except for 0 and 1.0 edge cases
  return num >= 0 && num <= 1 && !Number.isInteger(num * 10);
}